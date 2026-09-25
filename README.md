# NotificationIsland
<img width="500" height="360" alt="808422338 946440" src="https://github.com/user-attachments/assets/44865a10-4e10-4e5c-b67d-d1fe8e9c9745" />
<img width="500" height="360" alt="808422338 893899" src="https://github.com/user-attachments/assets/d20cbafa-9b03-4aa1-966b-f21f2b786641" />


> 在 iPhone Dynamic Island 上顯示自訂訊息的 iOS Live Activity 專案。

NotificationIsland 是一個以 **SwiftUI、ActivityKit、WidgetKit、App Intents** 製作的實驗性專案。

你可以從「捷徑」自動化執行 App Intent，把標題、訊息與 App 圖示顯示到 Dynamic Island。

> ⚠️ **目前僅支援 iOS 27**
>
> 目前尚未測試其他 iOS 版本。

## ✨ 目前功能

### Dynamic Island

執行捷徑中的：

**「顯示 Dynamic Island 訊息」**

即可顯示：

- 通知標題
- 通知訊息
- 選擇 App 圖示

Live Activity 會在啟動後約 **5 秒自動結束**。

### App 圖示

目前可以在捷徑中選擇：

| 圖示 | App |
|---|---|
| 🟢 | LINE |
| 🟣 | Instagram |
| 📧 | Gmail |
| 💬 | 訊息 |
| 🪩 | Retro |
| 🌱 | Pikmin Bloom |
| 🦉 | Duolingo |
| 📈 | 投資先生 |
| 🏦 | 台新銀行 |
| 💚 | StressWatch |
| ⚫ | Threads |

圖示會顯示在 Dynamic Island 中，用來模擬對應 App 的通知外觀。

### 點擊 Dynamic Island

目前點擊 Dynamic Island 會先開啟 **NotificationIsland**，再依照所選圖示嘗試跳轉到對應 App。

不同 App 的 URL Scheme、Universal Link 或 iOS 系統限制可能造成跳轉行為不同。

## 🔗 捷徑

https://www.icloud.com/shortcuts/022b6230e2f149198026cb6d905cfaa1

## 📱 系統需求

- **iOS 27**
- 支援 Dynamic Island 的 iPhone
- Apple Developer 帳號（自行簽署／側載時使用）
- Windows 使用者可以使用 GitHub Actions 建立 unsigned IPA，再透過 Sideloadly、iLoader 等工具自行簽署安裝

> ⚠️ 本專案目前以 **iOS 27** 為目標版本，其他版本不保證可以正常使用。

## 📲 安裝 unsigned IPA

GitHub Actions 產生的是 **unsigned IPA**，不能直接當成一般 App 安裝。

需要使用自己的 Apple ID 及簽署工具，例如：

- Sideloadly
- iLoader
- 其他合法的 iOS 側載／簽署工具

使用免費 Apple Developer 帳號時，App 的簽署期限及 App ID 數量等限制由 Apple 的開發者機制決定。

### Windows 使用者

本專案可以在 Windows 上開發，並使用 **GitHub Actions 的 macOS Runner** 建立 unsigned IPA。

```text
Windows
  ↓
GitHub
  ↓
GitHub Actions / macOS Runner
  ↓
unsigned IPA
  ↓
Sideloadly / iLoader
  ↓
iPhone
```

## ⚠️ 目前限制

這是一個實驗性專案，並不是 LINE、Instagram、Gmail、Apple、Retro、Pikmin Bloom、Duolingo、投資先生、台新銀行或 StressWatch 官方推出的通知工具。

目前的 App 圖示只是用來模擬不同 App 的通知外觀。

本專案**不能直接讀取 LINE、Instagram、Gmail、Apple 訊息或其他第三方 App 的私有系統通知內容**。

目前的使用方式是：

```text
捷徑
 ↓
NotificationIsland
 ↓
Live Activity
 ↓
Dynamic Island
```

而不是：

```text
LINE / Instagram / Gmail 等 App 收到真正通知
 ↓
NotificationIsland 自動讀取通知
 ↓
Dynamic Island
```

後者需要 iOS 系統允許的通知／自動化機制，不能單純靠一般 App 的 App Intent 直接讀取其他 App 的私有通知資料。

## 🛠️ 技術

- Swift
- SwiftUI
- ActivityKit
- WidgetKit
- App Intents
- Shortcuts
- Live Activities

## ⭐ Credits

本專案主要使用 Apple 提供的 ActivityKit、WidgetKit、App Intents、SwiftUI 與 Shortcuts / App Intents 製作。

## 💖 贊助支援 (Sponsor)

如果您覺得這個專案對您有幫助，歡迎透過加密貨幣贊助支持開發！

### Polygon (POL / ERC-20 Tokens)

<img width="398" height="581" alt="螢幕擷取畫面 2026-08-14 012349" src="https://github.com/user-attachments/assets/368d656f-d51c-4714-add6-82beac285763" />

- **Network:** Polygon (POS)
- **Address:** `0xFe8F7ae9526C9dE0CF4E793d4b313340c105E3Be`
