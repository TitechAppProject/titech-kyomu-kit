import Foundation

public struct KyomuCourse: Equatable, Codable {
    public let name: String
    public let periods: [KyomuCoursePeriod]
    public let quarters: [Int]
    public let code: String
    
    static func convert2Quarters(_ str: String) -> [Int] {
        let str = str.replacingOccurrences(of: "Q", with: "")
            .replacingOccurrences(of: "[～〜~]", with: "-", options: .regularExpression)
        
        if str.contains("-") {
            let res = str.split(separator: "-").compactMap { Int($0) }
            return res.count == 2 ? (res[0]...res[1]).map { $0 } : []
        } else if str.contains("・") {
            return str.split(separator: "・").compactMap { Int($0) }
        } else {
            return [str].compactMap { Int($0) }
        }
    }
}

public struct KyomuCoursePeriod: Equatable, Codable {
    public let day: DayOfWeek
    public let start: Int
    public let end: Int
    public let location: String
}

public enum DayOfWeek: Int, Codable, CaseIterable, Equatable {
    case unknown = 0
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
    
    static func convert(_ str: String) -> DayOfWeek {
        if str.contains("日") || str.contains("Sun") {
            return .sunday
        } else if str.contains("月") || str.contains("Mon") {
            return .monday
        } else if str.contains("火") || str.contains("Tue") {
            return .tuesday
        } else if str.contains("水") || str.contains("Wed") {
            return .wednesday
        } else if str.contains("木") || str.contains("Thu") {
            return .thursday
        } else if str.contains("金") || str.contains("Fri") {
            return .friday
        } else if str.contains("土") || str.contains("Sat") {
            return .saturday
        } else {
            return .unknown
        }
    }
}
