# NotificationIsland

<p align="center">
  <img src="./NotificationIsland/Assets.xcassets/AppIcon.appiconset/AppIcon.png" width="128" alt="NotificationIsland App Icon" />
</p>

> 使用「捷徑」把自訂通知顯示在 iPhone Dynamic Island，並在 App 內保留通知紀錄。

[English](./README_en.md) · [下載最新版 IPA](https://github.com/panda-island/NotificationIsland/releases/latest) · [加入捷徑](https://www.icloud.com/shortcuts/c50df63435ea4f5f927447d1431173a1)

> [!IMPORTANT]
> 目前支援 **iOS 27 或以上版本**，並建議使用配備 Dynamic Island 的 iPhone。

## 📲 安裝教學

### 1. 下載 IPA

前往 [GitHub Releases](https://github.com/panda-island/NotificationIsland/releases/latest)，下載最新版 `NotificationIsland-unsigned.ipa`。

### 2. 簽署並安裝

Release 提供的是 **unsigned IPA**，無法像 App Store App 一樣直接安裝。請使用自己的 Apple ID，透過下列其中一種合法簽署／側載工具安裝：

- Sideloadly
- iLoader
- 其他支援 iOS IPA 的簽署工具

免費 Apple Developer 帳號的簽署期限、App ID 數量與重新簽署限制，均由 Apple 的開發者機制決定。

### 3. 加入捷徑

安裝並開啟 App 後：

1. 點擊 App 內的「新增捷徑」。
2. 在 iCloud 捷徑頁加入「顯示 Dynamic Island 訊息」。
3. 在「捷徑」App 中設定標題、訊息與通知圖示。
4. 執行捷徑即可顯示 Dynamic Island 通知。

也可以直接開啟：[加入 NotificationIsland 捷徑](https://www.icloud.com/shortcuts/c50df63435ea4f5f927447d1431173a1)

## 🎬 使用畫面

<p align="center">
  <img src="./docs/media/notification-history.jpg" width="380" alt="NotificationIsland 設定與通知紀錄畫面" />
</p>

▶️ [點擊觀看 Dynamic Island 示範影片（MOV）](./docs/media/notification-island-demo.mov)

## ✨ App 功能

- **Dynamic Island 通知**：顯示自訂標題、訊息及 App 圖示。
- **5 秒自動消失**：Live Activity 顯示約 5 秒後自動移除。
- **即時覆蓋**：有新通知時立即移除舊的 Dynamic Island，顯示最新內容。
- **顯示開關**：可關閉 Dynamic Island，只保存通知紀錄。
- **通知紀錄**：保存標題、內容、圖示與時間，可刪除單筆或一次清除全部。
- **自動清理**：可關閉自動刪除，或設定紀錄保留 1～365 天，預設為 7 天。
- **多種通知圖示**：支援 LINE、Instagram、Gmail、訊息、Retro、Pikmin Bloom、Duolingo、投資先生、台新銀行、StressWatch、Reddit 與 Threads。
- **點擊跳轉**：點擊 Live Activity 後，依所選圖示嘗試開啟對應 App。

## 📱 系統需求

- iOS 27 或以上版本
- 建議使用支援 Dynamic Island 的 iPhone
- 自行簽署 IPA 時需要 Apple ID 與相容的簽署工具

## ⚠️ 使用限制

NotificationIsland 是使用 SwiftUI、ActivityKit、WidgetKit、App Intents 與 Shortcuts 製作的實驗性專案，並非 LINE、Instagram、Gmail、Apple 或其他第三方服務的官方通知工具。

本專案不能直接讀取其他 App 的私有系統通知。通知內容必須由使用者透過「捷徑」傳入：

```text
捷徑 → NotificationIsland → Live Activity → Dynamic Island
```

點擊後能否開啟對應 App，會受到該 App 的 URL Scheme、Universal Link 與 iOS 系統限制影響。

## 🛠️ 從原始碼建置

專案可在 Xcode 開啟 `NotificationIsland.xcodeproj` 建置。Windows 使用者也可 fork 專案，利用內建的 GitHub Actions macOS Runner 產生 unsigned IPA，再自行簽署安裝。

主要技術：Swift、SwiftUI、ActivityKit、WidgetKit、App Intents、Shortcuts、Live Activities。

## 💖 贊助支援 (Sponsor)

如果您覺得這個專案對您有幫助，歡迎透過加密貨幣贊助支持開發！

### Polygon (POL / ERC-20 Tokens)

<img width="398" height="581" alt="螢幕擷取畫面 2026-08-14 012349" src="https://github.com/user-attachments/assets/368d656f-d51c-4714-add6-82beac285763" />

- **Network:** Polygon (POS)
- **Address:** `0xFe8F7ae9526C9dE0CF4E793d4b313340c105E3Be`
