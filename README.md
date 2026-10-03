# NotificationIsland

<p align="center">
  <img src="./NotificationIsland/Assets.xcassets/AppIcon.appiconset/AppIcon.png" width="128" alt="NotificationIsland App Icon" />
</p>

> 使用「捷徑」把自訂通知顯示在 iPhone Dynamic Island，並在 App 內保留通知紀錄。

[English](./README_en.md) · [下載最新版 IPA](https://github.com/panda-island/NotificationIsland/releases/latest) · [加入捷徑](https://www.icloud.com/shortcuts/c50df63435ea4f5f927447d1431173a1)

> [!IMPORTANT]
> 目前支援 **iOS 27 或以上版本**。只有顯示 Dynamic Island 通知時才需要相容機型；如果只使用通知紀錄功能，裝置不需要支援 Dynamic Island。

## 📲 安裝教學

### 1. 下載 IPA

前往 [GitHub Releases](https://github.com/panda-island/NotificationIsland/releases/latest)，下載最新版 `NotificationIsland-unsigned.ipa`。

### 2. 使用 iLoader 簽署並側載

Release 提供的是 **unsigned IPA**，無法像 App Store App 一樣點一下直接安裝。以下以免費、開源且支援 Windows、macOS 與 Linux 的 **iLoader** 為例。

> [!WARNING]
> iLoader 會使用你的 Apple ID 向 Apple 申請開發用簽署。請只從 [iLoader 官方網站](https://iloader.app/) 或 [官方 GitHub 專案](https://github.com/nab138/iloader) 下載，不要使用來路不明的版本。iLoader 與 NotificationIsland 是彼此獨立的專案，並無官方隸屬或合作關係。

#### 電腦端準備

1. 從 [NotificationIsland Releases](https://github.com/panda-island/NotificationIsland/releases/latest) 下載 `NotificationIsland-unsigned.ipa`，記住檔案存放位置。
2. 前往 [iLoader 官方下載頁](https://iloader.app/) 下載適合電腦系統的最新版；也可以從 [iLoader GitHub Releases](https://github.com/nab138/iloader/releases/latest) 下載。
3. Windows 使用者需先依照 [Apple 官方說明安裝 iTunes／Apple Devices](https://support.apple.com/zh-tw/118290)，讓電腦具備與 iPhone 通訊所需的元件；macOS 已內建相關元件。
4. 使用 USB 傳輸線連接 iPhone，解鎖手機；首次連接時，請在 iPhone 上點擊「信任」並輸入裝置密碼。

#### 安裝 NotificationIsland

1. 開啟 iLoader，確認畫面中已辨識到你的 iPhone。
2. 選擇 **Import IPA**（匯入 IPA）。
3. 選取剛才下載的 `NotificationIsland-unsigned.ipa`。
4. 依畫面指示登入 Apple ID；若帳號已啟用雙重認證，請完成驗證。
5. 選擇可用的開發團隊／帳號，開始簽署與安裝。過程中請保持 iPhone 連線，直到 iLoader 顯示完成。
6. 回到 iPhone 主畫面，確認已出現 NotificationIsland。

#### 第一次開啟前

如果點擊 App 時出現「不受信任的開發者」或要求開啟開發者模式：

1. 前往「設定」→「一般」→「VPN 與裝置管理」，選擇你的 Apple ID 開發者描述檔並點擊「信任」。
2. 若系統要求，前往「設定」→「隱私權與安全性」→「開發者模式」開啟功能，依提示重新啟動 iPhone 並再次確認。
3. 重新開啟 NotificationIsland。

> [!NOTE]
> 使用免費 Apple Developer 帳號側載的 App 通常需要定期重新簽署，也可能受到可安裝 App 數量與 App ID 數量限制；實際限制由 Apple 決定。App 到期或無法開啟時，請在 iLoader 重新匯入同一個 IPA 並安裝。使用相同 Apple ID 與 Bundle ID 覆蓋安裝，通常可以保留 App 資料，但重要紀錄仍建議自行備份。

#### 常見問題

- **iLoader 找不到 iPhone：** 解鎖手機、重新插拔 USB、改用可傳輸資料的線材，並確認已在 iPhone 點擊「信任」。Windows 可依照 [Apple 官方說明](https://support.apple.com/zh-tw/118290) 安裝或重新啟動 iTunes／Apple Devices 後再試。
- **簽署或安裝失敗：** 先查看 iLoader 顯示的完整錯誤與建議；也可開啟 **View Logs** 取得記錄，再到 [iLoader Issues](https://github.com/nab138/iloader/issues) 查詢。
- **顯示已達 App ID／App 數量上限：** 移除不再使用的側載 App，或等候現有 App ID 到期後再試。
- **App 安裝後立刻無法開啟：** 確認已信任開發者描述檔並開啟開發者模式；若簽署已過期，請重新側載。

你也可以改用 [Sideloadly](https://sideloadly.io/) 或其他可信任、支援 unsigned IPA 的簽署工具；各工具畫面與步驟可能不同。

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

<p align="center">
  <img src="./docs/media/notification-island-demo.gif" width="720" alt="NotificationIsland Dynamic Island 示範動畫" />
</p>

## ✨ App 功能

- **Dynamic Island 通知**：顯示自訂標題、訊息及 App 圖示。
- **5 秒自動消失**：Live Activity 顯示約 5 秒後自動移除。
- **即時覆蓋**：有新通知時立即移除舊的 Dynamic Island，顯示最新內容。
- **顯示開關**：可關閉 Dynamic Island，只保存通知紀錄；此模式不需要支援 Dynamic Island 的裝置。
- **通知紀錄**：保存標題、內容、圖示與時間，可刪除單筆或一次清除全部。
- **自動清理**：可關閉自動刪除，或設定紀錄保留 1～365 天，預設為 7 天。
- **多種通知圖示**：支援 LINE、Instagram、Gmail、訊息、Retro、Pikmin Bloom、Duolingo、投資先生、台新銀行、StressWatch、Reddit 與 Threads。
- **點擊跳轉**：點擊 Live Activity 後，依所選圖示嘗試開啟對應 App。

## 📱 系統需求

- iOS 27 或以上版本
- 顯示 Dynamic Island 通知時，需要支援 Dynamic Island 的 iPhone
- 只使用通知紀錄功能時，不需要支援 Dynamic Island 的裝置
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
