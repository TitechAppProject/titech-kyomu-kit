import XCTest
@testable import TitechKyomuKit

final class TitechKyomuKitTests: XCTestCase {
    func testParseReportCheckPage() async throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlJa = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultJapanese", withExtension: "html")!)
        let htmlEn = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultEnglish", withExtension: "html")!)
        
        let resultJa = try await titechkyomu.parse(html: htmlJa)
        XCTAssertEqual(resultJa[0], Course(name: "分光学", periods: [CoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"), CoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202")], quarters: [1], code: "MAT.C302"))
        XCTAssertFalse(resultJa.contains(Course(name: "固体物理学(格子系)", periods: [CoursePeriod(day: .monday, start: 3, end: 4, location: "S8-102"), CoursePeriod(day: .thursday, start: 3, end: 4, location: "S8-102")], quarters: [1], code: "MAT.P301")))
        XCTAssertEqual(resultJa[6], Course(name: "アルゴリズムとデータ構造", periods: [], quarters: [2], code: "MCS.T213"))
        
        let resultEn = try await titechkyomu.parse(html: htmlEn)
        XCTAssertEqual(resultEn[0], Course(name: "Spectroscopy", periods: [CoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"), CoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202")], quarters: [1], code: "MAT.C302"))
        XCTAssertFalse(resultEn.contains(Course(name: "Solid State Physics (Lattice)", periods: [CoursePeriod(day: .monday, start: 3, end: 4, location: "S8-102"), CoursePeriod(day: .thursday, start: 3, end: 4, location: "S8-102")], quarters: [1], code: "MAT.P301")))
        XCTAssertEqual(resultEn[6], Course(name: "Introduction to Algorithms and Data Structures", periods: [], quarters: [2], code: "MCS.T213"))
        
    }
}
