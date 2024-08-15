import XCTest

@testable import TitechKyomuKit

final class TitechKyomuKitTestsOnProduction: XCTestCase {
    // To try on production environment, uncomment the following:

    //    let cookie = HTTPCookie(
    //        properties: [
    //            .name: "AUTH_SESSION_ID",
    //            .domain: ".titech.ac.jp",
    //            .path: "/",
    //            .value: "",  // use actual AUTH_SESSION_ID value
    //        ]
    //    )!
    //
    //    func testLoginOnProduction() async throws {
    //        TitechKyomu.changeToMockServer()
    //        let titechkyomu = TitechKyomu(urlSession: .shared)
    //        HTTPCookieStorage.shared.setCookie(cookie)
    //        try await titechkyomu.loginTopPage()
    //    }
    //
    //    func testParseReportCheckPageJaOnProduction() async throws {
    //        TitechKyomu.changeToMockServer()
    //        let titechkyomu = TitechKyomu(urlSession: .shared)
    //        HTTPCookieStorage.shared.setCookie(cookie)
    //        try await titechkyomu.loginTopPage()
    //        if let cookies = HTTPCookieStorage.shared.cookies {
    //            for cookie in cookies {
    //                if cookie.name == "Language" && cookie.value == "en-US" {
    //                    HTTPCookieStorage.shared.deleteCookie(cookie)
    //                    let cookieJa = HTTPCookie(
    //                        properties: [
    //                            .name: "Language",
    //                            .domain: "kyomu0.gakumu.titech.ac.jp",
    //                            .path: "/",
    //                            .value: "ja-JP",
    //                        ]
    //                    )!
    //                    HTTPCookieStorage.shared.setCookie(cookieJa)
    //                }
    //            }
    //        }
    //        let resultJa = try await titechkyomu.fetchKyomuCourseData()
    //        XCTAssertEqual(
    //            resultJa[0],
    //            KyomuCourse(
    //                name: "分光学",
    //                periods: [
    //                    KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"),
    //                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202"),
    //                ],
    //                year: 2024,
    //                quarters: [4],
    //                code: "MAT.C302",
    //                ocwId: "202202171",
    //                teachers: ["矢野 哲司", "北沢 信章"],
    //                isForm8: false
    //            )
    //        )
    //    }
    //
    //    func testParseReportCheckPageEnOnProduction() async throws {
    //        TitechKyomu.changeToMockServer()
    //        let titechkyomu = TitechKyomu(urlSession: .shared)
    //        HTTPCookieStorage.shared.setCookie(cookie)
    //        try await titechkyomu.loginTopPage()
    //        if let cookies = HTTPCookieStorage.shared.cookies {
    //            for cookie in cookies {
    //                if cookie.name == "Language" && cookie.value == "ja-JP" {
    //                    HTTPCookieStorage.shared.deleteCookie(cookie)
    //                    let cookieEn = HTTPCookie(
    //                        properties: [
    //                            .name: "Language",
    //                            .domain: "kyomu0.gakumu.titech.ac.jp",
    //                            .path: "/",
    //                            .value: "en-US",
    //                        ]
    //                    )!
    //                    HTTPCookieStorage.shared.setCookie(cookieEn)
    //                }
    //            }
    //        }
    //        let resultEn = try await titechkyomu.fetchKyomuCourseData()
    //        XCTAssertEqual(
    //            resultEn[0],
    //            KyomuCourse(
    //                name: "Spectroscopy",
    //                periods: [
    //                    KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"),
    //                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202"),
    //                ],
    //                year: 2024,
    //                quarters: [4],
    //                code: "MAT.C302",
    //                ocwId: "202202171",
    //                teachers: ["矢野 哲司", "北沢 信章"],
    //                isForm8: false
    //            )
    //        )
    //        XCTAssertTrue(
    //            resultEn.contains(
    //                KyomuCourse(
    //                    name: "Spectroscopy",
    //                    periods: [
    //                        KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"),
    //                        KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202"),
    //                    ],
    //                    year: 2024,
    //                    quarters: [4],
    //                    code: "MAT.C302",
    //                    ocwId: "202202171",
    //                    teachers: ["矢野 哲司", "北沢 信章"],
    //                    isForm8: false
    //                )
    //            )
    //        )
    //        XCTAssertFalse(
    //            resultEn.contains(
    //                KyomuCourse(
    //                    name: "Spectroscopy",
    //                    periods: [
    //                        KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"),
    //                        KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202"),
    //                    ],
    //                    year: 2024,
    //                    quarters: [4],
    //                    code: "MAT.C302",
    //                    ocwId: "202202171",
    //                    teachers: ["矢野 哲司", "北沢 信章"],
    //                    isForm8: false
    //                )
    //            )
    //        )
    //        XCTAssertEqual(
    //            resultEn[7],
    //            KyomuCourse(
    //                name: "Spectroscopy",
    //                periods: [
    //                    KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"),
    //                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202"),
    //                ],
    //                year: 2024,
    //                quarters: [4],
    //                code: "MAT.C302",
    //                ocwId: "202202171",
    //                teachers: ["矢野 哲司", "北沢 信章"],
    //                isForm8: false
    //            )
    //        )
    //    }
}
