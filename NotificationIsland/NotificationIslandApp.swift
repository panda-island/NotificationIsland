import SwiftUI
import UIKit

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
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "iphone.gen3")
                .font(.system(size: 50))
            Text("Notification Island")
                .font(.title2.bold())
            Text("在「捷徑」中使用「顯示 Dynamic Island 訊息」，即可把文字送到動態島。")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding(30)
        .onOpenURL { url in
            NotificationIslandApp.handleDeepLink(url)
        }
    }
}
