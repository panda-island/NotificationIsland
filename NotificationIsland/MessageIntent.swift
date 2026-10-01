import AppIntents
import ActivityKit
import UIKit

enum NotificationIcon: String, AppEnum {
    case line
    case instagram
    case gmail
    case messages
    case retro
    case pikminBloom
    case duolingo
    case investment
    case taishin
    case stressWatch
    case reddit
    case threads

    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        TypeDisplayRepresentation(name: "通知圖示")
    }

    static var caseDisplayRepresentations: [NotificationIcon: DisplayRepresentation] {
        [
            .line: DisplayRepresentation(title: "LINE"),
            .instagram: DisplayRepresentation(title: "Instagram"),
            .gmail: DisplayRepresentation(title: "Gmail"),
            .messages: DisplayRepresentation(title: "訊息"),
            .retro: DisplayRepresentation(title: "Retro"),
            .pikminBloom: DisplayRepresentation(title: "Pikmin Bloom"),
            .duolingo: DisplayRepresentation(title: "Duolingo"),
            .investment: DisplayRepresentation(title: "投資先生"),
            .taishin: DisplayRepresentation(title: "台新銀行"),
            .stressWatch: DisplayRepresentation(title: "StressWatch"),
            .reddit: DisplayRepresentation(title: "Reddit"),
            .threads: DisplayRepresentation(title: "Threads")
        ]
    }
}

struct ShowMessageIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "顯示 Dynamic Island 訊息"
    static var description = IntentDescription("顯示 Dynamic Island 訊息，5 秒後自動消失。")
    static var openAppWhenRun: Bool = false

    @Parameter(title: "標題")
    var titleText: String

    @Parameter(title: "訊息")
    var message: String

    @Parameter(title: "圖示")
    var icon: NotificationIcon

    init() {
        self.icon = .line
    }

    init(titleText: String, message: String, icon: NotificationIcon = .line) {
        self.titleText = titleText
        self.message = message
        self.icon = icon
    }

    func perform() async throws -> some IntentResult {
        let safeTitle = String(titleText.prefix(80))
        let safeMessage = String(message.prefix(300))

        let shouldShowLiveActivity = await NotificationHistoryStore.shared.record(
            title: safeTitle,
            message: safeMessage,
            icon: icon.rawValue
        )

        for old in Activity<MessageActivityAttributes>.activities {
            let oldContent = ActivityContent(
                state: old.content.state,
                staleDate: nil
            )
            await old.end(
                oldContent,
                dismissalPolicy: ActivityUIDismissalPolicy.immediate
            )
        }

        guard shouldShowLiveActivity else {
            return .result()
        }

        let attributes = MessageActivityAttributes(id: UUID().uuidString)
        let state = MessageActivityAttributes.ContentState(
            title: safeTitle,
            message: safeMessage,
            icon: icon.rawValue,
            tick: 0
        )

        let activity = try Activity.request(
            attributes: attributes,
            content: ActivityContent(
                state: state,
                staleDate: nil
            ),
            pushType: nil,
            style: .standard
        )

        // Keep only the short dismissal task alive after the intent returns.
        // A UIKit background-task assertion prevents iOS from suspending the app
        // before the five-second timer has a chance to end the Live Activity.
        await LiveActivityDismissalTask.schedule(
            activity: activity,
            finalState: state
        )

        return .result()
    }
}

@MainActor
private final class LiveActivityDismissalTask {
    private let activity: Activity<MessageActivityAttributes>
    private let finalState: MessageActivityAttributes.ContentState
    private var backgroundTaskID: UIBackgroundTaskIdentifier = .invalid
    private var dismissalTask: Task<Void, Never>?

    private init(
        activity: Activity<MessageActivityAttributes>,
        finalState: MessageActivityAttributes.ContentState
    ) {
        self.activity = activity
        self.finalState = finalState
    }

    static func schedule(
        activity: Activity<MessageActivityAttributes>,
        finalState: MessageActivityAttributes.ContentState
    ) {
        LiveActivityDismissalTask(
            activity: activity,
            finalState: finalState
        ).start()
    }

    private func start() {
        backgroundTaskID = UIApplication.shared.beginBackgroundTask(
            withName: "Dismiss Dynamic Island"
        ) { [weak self] in
            self?.handleExpiration()
        }

        dismissalTask = Task { [self] in
            do {
                try await Task.sleep(for: .seconds(5))
            } catch {
                return
            }

            await dismissActivity()
        }
    }

    private func handleExpiration() {
        dismissalTask?.cancel()
        dismissalTask = Task { [self] in
            await dismissActivity()
        }
    }

    private func dismissActivity() async {
        await activity.end(
            ActivityContent(
                state: finalState,
                staleDate: nil
            ),
            dismissalPolicy: ActivityUIDismissalPolicy.immediate
        )
        finishBackgroundTask()
    }

    private func finishBackgroundTask() {
        guard backgroundTaskID != .invalid else { return }
        UIApplication.shared.endBackgroundTask(backgroundTaskID)
        backgroundTaskID = .invalid
        dismissalTask = nil
    }
}
