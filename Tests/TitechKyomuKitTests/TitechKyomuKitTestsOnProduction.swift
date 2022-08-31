import XCTest
@testable import TitechKyomuKit

final class TitechKyomuKitTestsOnProduction: XCTestCase {
    let cookie = HTTPCookie(
        properties: [
            .name: "AUTH_SESSION_ID",
            .domain: ".titech.ac.jp",
            .path: "/",
            .value: ""  // use actual AUTH_SESSION_ID value
        ]
    )!
    // To try on production environment, uncomment the following:
    
//    func testLoginOnProduction() async throws {
//        let titechkyomu = TitechKyomu(urlSession: .shared)
//        HTTPCookieStorage.shared.setCookie(cookie)
//        let resultLogin = try await titechkyomu.fetchTopPage()
//        XCTAssertTrue(resultLogin)
//    }
//
//    func testParseReportCheckPageJaOnProduction() async throws {
//        let titechkyomu = TitechKyomu(urlSession: .shared)
//        HTTPCookieStorage.shared.setCookie(cookie)
//        let resultLogin = try await titechkyomu.fetchTopPage()
//        XCTAssertTrue(resultLogin)
//        if let cookies = HTTPCookieStorage.shared.cookies {
//            for cookie in cookies {
//                if (cookie.name == "Language" && cookie.value == "en-US") {
//                    HTTPCookieStorage.shared.deleteCookie(cookie)
//                    let cookieJa = HTTPCookie(
//                        properties: [
//                            .name: "Language",
//                            .domain: "kyomu2.gakumu.titech.ac.jp",
//                            .path: "/",
//                            .value: "ja-JP"
//                        ]
//                    )!
//                    HTTPCookieStorage.shared.setCookie(cookieJa)
//                }
//            }
//        }
//        let resultJa = try await titechkyomu.fetchKyomuCourseData()
//        XCTAssertEqual(resultJa[0], KyomuCourse(name: "分光学", periods: [KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"), KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202")], quarters: [1], code: "MAT.C302"))
//        XCTAssertTrue(resultJa.contains(KyomuCourse(name: "固体物理学(格子系)", periods: [KyomuCoursePeriod(day: .monday, start: 3, end: 4, location: "S8-102"), KyomuCoursePeriod(day: .thursday, start: 3, end: 4, location: "S8-102")], quarters: [1], code: "MAT.P301")))
//        XCTAssertFalse(resultJa.contains(KyomuCourse(name: "架空の科目", periods: [KyomuCoursePeriod(day: .monday, start: 3, end: 4, location: "S8-102"), KyomuCoursePeriod(day: .thursday, start: 3, end: 4, location: "S8-102")], quarters: [1], code: "MAT.P301")))
//        XCTAssertEqual(resultJa[7], KyomuCourse(name: "アルゴリズムとデータ構造", periods: [], quarters: [2], code: "MCS.T213"))
//    }
//
//    func testParseReportCheckPageEnOnProduction() async throws {
//        let titechkyomu = TitechKyomu(urlSession: .shared)
//        HTTPCookieStorage.shared.setCookie(cookie)
//        let resultLogin = try await titechkyomu.fetchTopPage()
//        XCTAssertTrue(resultLogin)
//        if let cookies = HTTPCookieStorage.shared.cookies {
//            for cookie in cookies {
//                if (cookie.name == "Language" && cookie.value == "ja-JP") {
//                    HTTPCookieStorage.shared.deleteCookie(cookie)
//                    let cookieEn = HTTPCookie(
//                        properties: [
//                            .name: "Language",
//                            .domain: "kyomu2.gakumu.titech.ac.jp",
//                            .path: "/",
//                            .value: "en-US"
//                        ]
//                    )!
//                    HTTPCookieStorage.shared.setCookie(cookieEn)
//                }
//            }
//        }
//        let resultEn = try await titechkyomu.fetchKyomuCourseData()
//        print(resultEn)
//        XCTAssertEqual(resultEn[0], KyomuCourse(name: "Spectroscopy", periods: [KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"), KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202")], quarters: [1], code: "MAT.C302"))
//        XCTAssertTrue(resultEn.contains(KyomuCourse(name: "Solid State Physics (Lattice)", periods: [KyomuCoursePeriod(day: .monday, start: 3, end: 4, location: "S8-102"), KyomuCoursePeriod(day: .thursday, start: 3, end: 4, location: "S8-102")], quarters: [1], code: "MAT.P301")))
//        XCTAssertFalse(resultEn.contains(KyomuCourse(name: "Course that no longer exists", periods: [KyomuCoursePeriod(day: .monday, start: 3, end: 4, location: "S8-102"), KyomuCoursePeriod(day: .thursday, start: 3, end: 4, location: "S8-102")], quarters: [1], code: "MAT.P301")))
//        XCTAssertEqual(resultEn[7], KyomuCourse(name: "Introduction to Algorithms and Data Structures", periods: [], quarters: [2], code: "MCS.T213"))
//    }
}
