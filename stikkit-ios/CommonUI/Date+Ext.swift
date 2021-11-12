import UIKit

extension Date {
    
    private static let dateFormatter = DateFormatter()
    
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current) + " ago"
    }
    
    static func formattedDate(createdAt: Int64) -> String {
        let timeInterval: Double =  Double(createdAt / 1_000_000_000)
        let date: Date = Date(timeIntervalSince1970: timeInterval)
        if let midnightDate: Date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()), date > midnightDate {
            dateFormatter.dateFormat = "HH:mm"
        } else if let previousWeekDate: Date = Calendar.current.date(byAdding: .day, value: -7, to: Date()), date > previousWeekDate {
            dateFormatter.dateFormat = "E"
        } else {
            dateFormatter.dateFormat = "MM/dd/yyyy"
        }
        
        return dateFormatter.string(from: date).lowercased()
    }
}
