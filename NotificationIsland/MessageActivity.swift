import Foundation
import ActivityKit

struct MessageActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var title: String
        var message: String
        var icon: String
        var tick: Int
    }

    var id: String
}

struct NotificationRecord: Codable, Identifiable, Equatable, Sendable {
    let id: UUID
    let title: String
    let message: String
    let icon: String
    let createdAt: Date
}

struct NotificationHistorySnapshot: Equatable, Sendable {
    let records: [NotificationRecord]
    let retentionDays: Int
    let showsLiveActivity: Bool
}

actor NotificationHistoryStore {
    static let shared = NotificationHistoryStore()

    private enum Keys {
        static let records = "notificationHistory.records"
        static let retentionDays = "notificationHistory.retentionDays"
        static let showsLiveActivity = "notificationHistory.showsLiveActivity"
    }

    private let defaults = UserDefaults.standard
    private let defaultRetentionDays = 7

    private init() {
        if defaults.object(forKey: Keys.retentionDays) == nil {
            defaults.set(defaultRetentionDays, forKey: Keys.retentionDays)
        }
        if defaults.object(forKey: Keys.showsLiveActivity) == nil {
            defaults.set(true, forKey: Keys.showsLiveActivity)
        }
    }

    @discardableResult
    func record(title: String, message: String, icon: String, now: Date = Date()) -> Bool {
        var records = prunedRecords(from: loadRecords(), now: now)
        records.insert(
            NotificationRecord(
                id: UUID(),
                title: title,
                message: message,
                icon: icon,
                createdAt: now
            ),
            at: 0
        )
        save(records)
        return showsLiveActivity
    }

    func snapshot(now: Date = Date()) -> NotificationHistorySnapshot {
        let storedRecords = loadRecords()
        let records = prunedRecords(from: storedRecords, now: now)

        if records != storedRecords {
            save(records)
        }

        return NotificationHistorySnapshot(
            records: records,
            retentionDays: retentionDays,
            showsLiveActivity: showsLiveActivity
        )
    }

    func setRetentionDays(_ days: Int, now: Date = Date()) -> NotificationHistorySnapshot {
        defaults.set(min(max(days, 0), 365), forKey: Keys.retentionDays)
        return snapshot(now: now)
    }

    func setShowsLiveActivity(_ isEnabled: Bool, now: Date = Date()) -> NotificationHistorySnapshot {
        defaults.set(isEnabled, forKey: Keys.showsLiveActivity)
        return snapshot(now: now)
    }

    func delete(id: NotificationRecord.ID, now: Date = Date()) -> NotificationHistorySnapshot {
        var records = prunedRecords(from: loadRecords(), now: now)
        records.removeAll { $0.id == id }
        save(records)
        return NotificationHistorySnapshot(
            records: records,
            retentionDays: retentionDays,
            showsLiveActivity: showsLiveActivity
        )
    }

    func clear() -> NotificationHistorySnapshot {
        save([])
        return NotificationHistorySnapshot(
            records: [],
            retentionDays: retentionDays,
            showsLiveActivity: showsLiveActivity
        )
    }

    private var retentionDays: Int {
        guard defaults.object(forKey: Keys.retentionDays) != nil else {
            return defaultRetentionDays
        }
        return min(max(defaults.integer(forKey: Keys.retentionDays), 0), 365)
    }

    private var showsLiveActivity: Bool {
        guard defaults.object(forKey: Keys.showsLiveActivity) != nil else { return true }
        return defaults.bool(forKey: Keys.showsLiveActivity)
    }

    private func loadRecords() -> [NotificationRecord] {
        guard let data = defaults.data(forKey: Keys.records),
              let records = try? JSONDecoder().decode([NotificationRecord].self, from: data) else {
            return []
        }
        return records.sorted { $0.createdAt > $1.createdAt }
    }

    private func save(_ records: [NotificationRecord]) {
        guard let data = try? JSONEncoder().encode(records) else { return }
        defaults.set(data, forKey: Keys.records)
    }

    private func prunedRecords(from records: [NotificationRecord], now: Date) -> [NotificationRecord] {
        let days = retentionDays
        guard days > 0,
              let cutoffDate = Calendar.current.date(byAdding: .day, value: -days, to: now) else {
            return records
        }
        return records.filter { $0.createdAt >= cutoffDate }
    }
}
