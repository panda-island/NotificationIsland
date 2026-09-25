# NotificationIsland
<img width="500" height="360" alt="808422338 946440" src="https://github.com/user-attachments/assets/44865a10-4e10-4e5c-b67d-d1fe8e9c9745" />
<img width="500" height="360" alt="808422338 893899" src="https://github.com/user-attachments/assets/d20cbafa-9b03-4aa1-966b-f21f2b786641" />


> An experimental iOS Live Activity project for displaying custom messages on the iPhone Dynamic Island.

NotificationIsland is an experimental project built with **SwiftUI, ActivityKit, WidgetKit, and App Intents**.

You can trigger the App Intent from the **Shortcuts** app and display a custom title, message, and app icon on the Dynamic Island.

> ⚠️ **Currently supports iOS 27 **
>
> Other iOS versions have not been tested yet.

## ✨ Features

### Dynamic Island

Run the Shortcut action:

**「顯示 Dynamic Island 訊息」**

You can display:

- A notification title
- A notification message
- A selectable app icon

The Live Activity automatically ends after approximately **5 seconds**.

### App Icons

| Icon | App |
|---|---|
| 🟢 | LINE |
| 🟣 | Instagram |
| 📧 | Gmail |
| 💬 | Messages |
| 🪩 | Retro |
| 🌱 | Pikmin Bloom |
| 🦉 | Duolingo |
| 📈 | Investment Master |
| 🏦 | Taishin Bank |
| 💚 | StressWatch |
| ⚫ | Threads |

The selected icon is displayed on the Dynamic Island to simulate the appearance of a notification from the corresponding app.

### Tapping the Dynamic Island

Currently, tapping the Dynamic Island first opens **NotificationIsland**, which then attempts to open the corresponding app.

The behavior may vary depending on each app's URL Scheme, Universal Link support, or iOS system restrictions.

## 🔗 Shortcut

https://www.icloud.com/shortcuts/022b6230e2f149198026cb6d905cfaa1

## 📱 Requirements

- **iOS 27**
- An iPhone with Dynamic Island support
- An Apple Developer account for signing / sideloading
- Windows users can use GitHub Actions to build an unsigned IPA, then sign and install it using Sideloadly, iLoader, or another legitimate iOS sideloading/signing tool

> ⚠️ This project currently targets **iOS 27**. Other versions are not guaranteed to work.

## 📲 Installing the Unsigned IPA

The IPA produced by GitHub Actions is an **unsigned IPA** and cannot be installed like a normal App Store application.

You need to sign it with your own Apple ID using a signing tool such as:

- Sideloadly
- iLoader
- Other legitimate iOS sideloading/signing tools

When using a free Apple Developer account, signing duration, App ID limits, and other restrictions are determined by Apple's developer system.

### Windows Users

The project can be developed on Windows and built using a **GitHub Actions macOS Runner**.

```text
Windows
  ↓
GitHub
  ↓
GitHub Actions / macOS Runner
  ↓
Unsigned IPA
  ↓
Sideloadly / iLoader
  ↓
iPhone
```

## ⚠️ Current Limitations

This is an experimental project. It is **not an official notification tool** from LINE, Instagram, Gmail, Apple, Retro, Pikmin Bloom, Duolingo, Investment Master, Taishin Bank, or StressWatch.

The app icons are currently used only to simulate the appearance of notifications from different apps.

This project **cannot directly read private system notification contents** from LINE, Instagram, Gmail, Messages, or other third-party apps.

The current workflow is:

```text
Shortcuts
 ↓
NotificationIsland
 ↓
Live Activity
 ↓
Dynamic Island
```

It is **not**:

```text
LINE / Instagram / Gmail receives a real notification
 ↓
NotificationIsland automatically reads the notification
 ↓
Dynamic Island
```

The latter requires notification or automation capabilities permitted by iOS. A normal App Intent cannot simply read private notification data belonging to other apps.

## 🛠️ Tech Stack

- Swift
- SwiftUI
- ActivityKit
- WidgetKit
- App Intents
- Shortcuts
- Live Activities

## ⭐ Credits

Built primarily with Apple's ActivityKit, WidgetKit, App Intents, SwiftUI, and Shortcuts / App Intents.

## 💖 Sponsor

If you find this project useful, you are welcome to support development through cryptocurrency.

### Polygon (POL / ERC-20 Tokens)

<img width="398" height="581" alt="Screenshot 2026-08-14 012349" src="https://github.com/user-attachments/assets/368d656f-d51c-4714-add6-82beac285763" />

- **Network:** Polygon (POS)
- **Address:** `0xFe8F7ae9526C9dE0CF4E793d4b313340c105E3Be`
