import AppIntents
import ActivityKit

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

        let attributes = MessageActivityAttributes(id: UUID().uuidString)
        let state = MessageActivityAttributes.ContentState(
            title: safeTitle,
            message: safeMessage,
            icon: icon.rawValue,
            tick: 0
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

        let activity = try Activity.request(
            attributes: attributes,
            content: ActivityContent(
                state: state,
                staleDate: nil
            ),
            pushType: nil,
            style: .standard
        )

        // Don't keep the App Intent running during the five-second display period.
        // Returning immediately lets a new Shortcut invocation end this activity
        // and replace it without waiting for the previous notification to expire.
        Task {
            for tick in 0..<10 {
                let updatedState = MessageActivityAttributes.ContentState(
                    title: safeTitle,
                    message: safeMessage,
                    icon: icon.rawValue,
                    tick: tick
                )

                await activity.update(
                    ActivityContent(
                        state: updatedState,
                        staleDate: nil,
                        relevanceScore: 100
                    )
                )

                try? await Task.sleep(for: .milliseconds(500))
            }

            await activity.end(
                ActivityContent(
                    state: state,
                    staleDate: nil
                ),
                dismissalPolicy: ActivityUIDismissalPolicy.immediate
            )
        }

        return .result()
    }
}
