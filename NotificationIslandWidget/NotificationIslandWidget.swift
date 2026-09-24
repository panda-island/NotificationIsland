import WidgetKit
import SwiftUI
import ActivityKit
import UIKit

struct MessageActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var title: String
        var message: String
        var icon: String
        var tick: Int
    }

    var id: String
}

struct NotificationIslandWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MessageActivityAttributes.self) { context in
            HStack(spacing: 10) {
                notificationIcon(context.state.icon, size: 36)

                VStack(alignment: .leading, spacing: 3) {
                    Text(context.state.title)
                        .font(.headline)
                        .lineLimit(1)
                    Text(context.state.message)
                        .font(.body)
                        .lineLimit(3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    VStack {
                        Spacer(minLength: 0)
                        notificationIcon(context.state.icon, size: 42)
                        Spacer(minLength: 0)
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    .padding(.leading, 8)
                }

                DynamicIslandExpandedRegion(.center) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(context.state.title)
                            .font(.headline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)

                        Text(context.state.message)
                            .font(.subheadline)
                            .lineLimit(2)
                            .minimumScaleFactor(0.72)
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 4)
                }

                DynamicIslandExpandedRegion(.trailing) {
                    Text(appDisplayName(for: context.state.icon))
                        .font(.caption)
                        .lineLimit(1)
                        .minimumScaleFactor(0.65)
                        .frame(maxWidth: 76, alignment: .trailing)
                        .padding(.trailing, 6)
                }
            } compactLeading: {
                notificationIcon(context.state.icon, size: 18)
            } compactTrailing: {
                Text(context.state.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .frame(maxWidth: 72)
            } minimal: {
                notificationIcon(context.state.icon, size: 18)
            }
            .widgetURL(deepLink(for: context.state.icon))
        }
    }

    @ViewBuilder
    private func notificationIcon(_ icon: String, size: CGFloat) -> some View {
        let imageName = resourceName(for: icon)
        if let image = UIImage(named: imageName, in: Bundle.main, compatibleWith: nil) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: size * 0.22))
                .accessibilityLabel(imageName)
        } else {
            Image(systemName: "message.fill")
                .font(.system(size: size * 0.72))
                .frame(width: size, height: size)
        }
    }

    private func resourceName(for icon: String) -> String {
        switch icon {
        case "instagram": return "Instagram"
        case "gmail": return "Gmail"
        case "messages": return "Messages"
        case "retro": return "Retro"
        case "pikminBloom": return "PikminBloom"
        case "duolingo": return "Duolingo"
        case "investment": return "Investment"
        case "taishin": return "Taishin"
        case "stressWatch": return "StressWatch"
        case "reddit": return "Reddit"
        case "threads": return "Threads"
        default: return "LINE"
        }
    }

    private func appDisplayName(for icon: String) -> String {
        switch icon {
        case "line": return "LINE"
        case "instagram": return "Instagram"
        case "gmail": return "Gmail"
        case "messages": return "訊息"
        case "retro": return "Retro"
        case "pikminBloom": return "Pikmin Bloom"
        case "duolingo": return "Duolingo"
        case "investment": return "投資先生"
        case "taishin": return "台新銀行"
        case "stressWatch": return "StressWatch"
        case "reddit": return "Reddit"
        case "threads": return "Threads"
        default: return "LINE"
        }
    }

    private func deepLink(for icon: String) -> URL? {
        // Directly open the selected app using its app-name:// URL scheme.
        switch icon {
        case "line": return URL(string: "line://")
        case "instagram": return URL(string: "instagram://")
        case "gmail": return URL(string: "gmail://")
        case "messages": return URL(string: "messages://")
        case "retro": return URL(string: "retro://")
        case "pikminBloom": return URL(string: "pikminbloom://")
        case "duolingo": return URL(string: "duolingo://")
        case "investment": return URL(string: "investment://")
        case "taishin": return URL(string: "taishin://")
        case "stressWatch": return URL(string: "stresswatch://")
        case "reddit": return URL(string: "reddit://")
        case "threads": return URL(string: "notificationisland://threads")
        default: return URL(string: "line://")
        }
    }
}
