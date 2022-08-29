import XCTest
@testable import TitechKyomuKit

final class TitechKyomuKitTests: XCTestCase {
    func testParseReportCheckPageJa() async throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlJa = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultJapanese", withExtension: "html")!)
        
        let resultJa = try await titechkyomu.parseReportCheckPage(html: htmlJa)
        XCTAssertEqual(resultJa[0], KyomuCourse(name: "分光学", periods: [KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"), KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202")], quarters: [1], code: "MAT.C302"))
        XCTAssertFalse(resultJa.contains(KyomuCourse(name: "固体物理学(格子系)", periods: [KyomuCoursePeriod(day: .monday, start: 3, end: 4, location: "S8-102"), KyomuCoursePeriod(day: .thursday, start: 3, end: 4, location: "S8-102")], quarters: [1], code: "MAT.P301")))
        XCTAssertEqual(resultJa[6], KyomuCourse(name: "アルゴリズムとデータ構造", periods: [], quarters: [2], code: "MCS.T213"))
    }
    
    func testParseReportCheckPageEn() async throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlEn = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultEnglish", withExtension: "html")!)
        
        let resultEn = try await titechkyomu.parseReportCheckPage(html: htmlEn)
        XCTAssertEqual(resultEn[0], KyomuCourse(name: "Spectroscopy", periods: [KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"), KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202")], quarters: [1], code: "MAT.C302"))
        XCTAssertFalse(resultEn.contains(KyomuCourse(name: "Solid State Physics (Lattice)", periods: [KyomuCoursePeriod(day: .monday, start: 3, end: 4, location: "S8-102"), KyomuCoursePeriod(day: .thursday, start: 3, end: 4, location: "S8-102")], quarters: [1], code: "MAT.P301")))
        XCTAssertEqual(resultEn[6], KyomuCourse(name: "Introduction to Algorithms and Data Structures", periods: [], quarters: [2], code: "MCS.T213"))
    }
    
    func testLogin() async throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let authSessionId = ""
        let cookie = HTTPCookie(
            properties: [
                .name: "AUTH_SESSION_ID",
                .domain: ".titech.ac.jp",
                .path: "/",
                .value: authSessionId
            ]
        )!
        HTTPCookieStorage.shared.setCookie(cookie)
        let resultLogin = try await titechkyomu.loginToTop()
        print(resultLogin)
        let resultFetch = try await titechkyomu.fetchKyomuCourseData()
        print(resultFetch)
    }
}
