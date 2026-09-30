import SwiftUI
import UIKit
import Observation

@main
struct NotificationIslandApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    static func handleDeepLink(_ url: URL) {
        guard url.scheme == "notificationisland" else { return }

        switch url.host {
        case "line":
            openApp("line://", fallback: "https://line.me/")

        case "instagram":
            openApp("instagram://app", fallback: "https://www.instagram.com/")

        case "gmail":
            openApp("googlegmail://", fallback: "https://mail.google.com/")

        case "messages":
            // sms:// opens Apple's Messages app.
            UIApplication.shared.open(URL(string: "sms:")!)

        case "retro":
            // Retro's web domain is used as the fallback/universal-link target.
            openApp("https://retro.app", fallback: "https://retro.app")

        case "pikminBloom":
            // No publicly documented iOS custom URL scheme was found.
            // Fall back to the App Store listing rather than guessing a scheme.
            openApp("itms-apps://itunes.apple.com/app/id1556357398",
                    fallback: "https://apps.apple.com/tw/app/pikmin-bloom/id1556357398")

        case "duolingo":
            // Publicly documented third-party URL scheme.
            openApp("duolingo://com.duolingo.DuolingoMobile",
                    fallback: "https://apps.apple.com/tw/app/duolingo-language-lessons/id570060128")

        case "investment":
            // 投資先生 (Yuanta Securities), App Store ID 1382114621.
            openApp("itms-apps://itunes.apple.com/app/id1382114621",
                    fallback: "https://apps.apple.com/tw/app/id1382114621")

        case "taishin":
            // 台新銀行行動銀行, App Store ID 388917170.
            openApp("itms-apps://itunes.apple.com/app/id388917170",
                    fallback: "https://apps.apple.com/tw/app/id388917170")

        case "stressWatch":
            // No publicly documented iOS custom URL scheme was found.
            openApp("itms-apps://itunes.apple.com/app/id6444737095",
                    fallback: "https://apps.apple.com/tw/app/id6444737095")

        case "threads":
            openApp("https://www.threads.com/", fallback: "https://www.threads.com/")

        case "reddit":
            openApp("reddit://", fallback: "https://www.reddit.com/")

        default:
            break
        }
    }

    private static func openApp(_ appURLString: String, fallback: String) {
        guard let appURL = URL(string: appURLString),
              let fallbackURL = URL(string: fallback) else { return }

        UIApplication.shared.open(appURL, options: [:]) { success in
            if !success {
                UIApplication.shared.open(fallbackURL)
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var model = NotificationHistoryModel()
    @State private var isShowingClearConfirmation = false

    var body: some View {
        @Bindable var model = model

        NavigationStack {
            List {
                RetentionSettingsSection(
                    isEnabled: $model.isAutoDeleteEnabled,
                    retentionDays: $model.retentionDays
                )

                Section {
                    if model.records.isEmpty {
                        ContentUnavailableView(
                            "尚無通知紀錄",
                            systemImage: "bell.slash",
                            description: Text("從「捷徑」顯示 Dynamic Island 訊息後，紀錄會出現在這裡。")
                        )
                    } else {
                        ForEach(model.records) { record in
                            NotificationHistoryRow(record: record)
                                .swipeActions {
                                    Button("刪除", systemImage: "trash", role: .destructive) {
                                        Task { await model.delete(record.id) }
                                    }
                                }
                        }
                    }
                } header: {
                    Text("通知紀錄")
                } footer: {
                    if !model.records.isEmpty {
                        Text("共 \(model.records.count) 則紀錄")
                    }
                }
            }
            .navigationTitle("Notification Island")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("全部清除", systemImage: "trash", role: .destructive) {
                        isShowingClearConfirmation = true
                    }
                    .disabled(model.records.isEmpty)
                }
            }
            .confirmationDialog(
                "要清除所有通知紀錄嗎？",
                isPresented: $isShowingClearConfirmation,
                titleVisibility: .visible
            ) {
                Button("全部清除", role: .destructive) {
                    Task { await model.clear() }
                }
                Button("取消", role: .cancel) { }
            } message: {
                Text("此動作無法復原。")
            }
        }
        .task {
            await model.reload()
        }
        .onChange(of: scenePhase) { _, phase in
            guard phase == .active else { return }
            Task { await model.reload() }
        }
        .onChange(of: model.isAutoDeleteEnabled) { _, isEnabled in
            Task { await model.setAutoDeleteEnabled(isEnabled) }
        }
        .onChange(of: model.retentionDays) { _, days in
            guard model.isAutoDeleteEnabled else { return }
            Task { await model.setRetentionDays(days) }
        }
        .onOpenURL { url in
            NotificationIslandApp.handleDeepLink(url)
        }
    }
}

@MainActor
@Observable
final class NotificationHistoryModel {
    var records: [NotificationRecord] = []
    var isAutoDeleteEnabled = true
    var retentionDays = 7

    private let store = NotificationHistoryStore.shared

    func reload() async {
        apply(await store.snapshot())
    }

    func setAutoDeleteEnabled(_ isEnabled: Bool) async {
        let days = isEnabled ? max(retentionDays, 1) : 0
        apply(await store.setRetentionDays(days))
    }

    func setRetentionDays(_ days: Int) async {
        apply(await store.setRetentionDays(days))
    }

    func delete(_ id: NotificationRecord.ID) async {
        apply(await store.delete(id: id))
    }

    func clear() async {
        apply(await store.clear())
    }

    private func apply(_ snapshot: NotificationHistorySnapshot) {
        records = snapshot.records

        if snapshot.retentionDays > 0 {
            isAutoDeleteEnabled = true
            retentionDays = snapshot.retentionDays
        } else {
            isAutoDeleteEnabled = false
            retentionDays = max(retentionDays, 1)
        }
    }
}

private struct RetentionSettingsSection: View {
    @Binding var isEnabled: Bool
    @Binding var retentionDays: Int

    var body: some View {
        Section {
            Toggle("自動刪除", isOn: $isEnabled)

            Stepper(value: $retentionDays, in: 1...365) {
                LabeledContent("保留時間", value: "\(retentionDays) 天")
            }
            .disabled(!isEnabled)
        } header: {
            Text("紀錄設定")
        } footer: {
            Text(isEnabled ? "超過保留時間的紀錄會自動刪除。" : "通知紀錄會持續保留，直到你手動刪除。")
        }
    }
}

private struct NotificationHistoryRow: View {
    let record: NotificationRecord

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            NotificationIconBadge(icon: record.icon)

            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(record.title.isEmpty ? "無標題" : record.title)
                        .font(.headline)
                        .lineLimit(1)

                    Spacer(minLength: 8)

                    Text(record.createdAt, format: .dateTime.month().day().hour().minute())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Text(record.message.isEmpty ? "無訊息內容" : record.message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)

                Text(record.appDisplayName)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}

private struct NotificationIconBadge: View {
    let icon: String

    var body: some View {
        Image(systemName: symbolName)
            .font(.headline)
            .foregroundStyle(tint)
            .frame(width: 38, height: 38)
            .background(tint.opacity(0.14), in: .rect(cornerRadius: 10))
            .accessibilityHidden(true)
    }

    private var symbolName: String {
        switch icon {
        case "instagram": "camera.fill"
        case "gmail": "envelope.fill"
        case "messages": "message.fill"
        case "retro": "photo.on.rectangle.angled"
        case "pikminBloom": "leaf.fill"
        case "duolingo": "character.book.closed.fill"
        case "investment": "chart.line.uptrend.xyaxis"
        case "taishin": "building.columns.fill"
        case "stressWatch": "heart.text.square.fill"
        case "reddit": "bubble.left.and.bubble.right.fill"
        case "threads": "at"
        default: "bubble.left.fill"
        }
    }

    private var tint: Color {
        switch icon {
        case "line", "pikminBloom", "duolingo": .green
        case "instagram": .purple
        case "gmail": .red
        case "messages": .blue
        case "retro": .indigo
        case "investment": .orange
        case "taishin": .pink
        case "stressWatch": .mint
        case "reddit": .orange
        default: .primary
        }
    }
}

private extension NotificationRecord {
    var appDisplayName: String {
        switch icon {
        case "line": "LINE"
        case "instagram": "Instagram"
        case "gmail": "Gmail"
        case "messages": "訊息"
        case "retro": "Retro"
        case "pikminBloom": "Pikmin Bloom"
        case "duolingo": "Duolingo"
        case "investment": "投資先生"
        case "taishin": "台新銀行"
        case "stressWatch": "StressWatch"
        case "reddit": "Reddit"
        case "threads": "Threads"
        default: "通知"
        }
    }
}
