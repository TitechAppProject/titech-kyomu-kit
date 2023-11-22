import XCTest
@testable import TitechKyomuKit

final class TitechKyomuKitTests: XCTestCase {
    func testParseTopPageJa() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlJa = try! String(contentsOf: Bundle.module.url(forResource: "TopJapanese", withExtension: "html")!)
        let resultJa = try titechkyomu.parseTopPage(html: htmlJa)
        XCTAssertTrue(resultJa)
    }
    
    func testParseTopPageEn() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlEn = try! String(contentsOf: Bundle.module.url(forResource: "TopEnglish", withExtension: "html")!)
        let resultEn = try titechkyomu.parseTopPage(html: htmlEn)
        XCTAssertTrue(resultEn)
    }
    
    func testParseTopPageMaintenance() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlMaintenance = try! String(contentsOf: Bundle.module.url(forResource: "TopMaintenance", withExtension: "html")!)
        let resultMaintenance = try titechkyomu.parseTopPage(html: htmlMaintenance)
        XCTAssertFalse(resultMaintenance)
    }
    
    func testParseReportCheckPageJa() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlJa = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultJapanese", withExtension: "html")!)
        
        let resultJa = try titechkyomu.parseReportCheckPage(html: htmlJa)
        XCTAssertEqual(
            resultJa[0],
            KyomuCourse(
                name: "分光学",
                periods: [KyomuCoursePeriod(day: .monday, start: 11, end: 12, location: "S7-202(S000)"),
                          KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202")],
                year: 2022,
                quarters: [1],
                code: "MAT.C302",
                ocwId: "202202171",
                isForm8: false
            )
        )
        XCTAssertFalse(resultJa.contains { $0.name == "固体物理学(格子系)" })
        XCTAssertEqual(
            resultJa[6],
            KyomuCourse(
                name: "アルゴリズムとデータ構造",
                periods: [],
                year: 2022,
                quarters: [2],
                code: "MCS.T213",
                ocwId: "202202382",
                isForm8: false
            )
        )
        XCTAssertEqual(
            resultJa[7],
            KyomuCourse(
                name: "確率微分方程式",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 3, end: 4, location: "W931"),
                    KyomuCoursePeriod(day: .friday, start: 3, end: 4, location: "W931")
                ],
                year: 2022,
                quarters: [4],
                code: "MCS.T419",
                ocwId: "202217437",
                isForm8: true
            )
        )
        XCTAssertEqual(
            resultJa[8],
            KyomuCourse(
                name: "システム構築演習",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 3, end: 4, location: "情報工学系計算機室"),
                    KyomuCoursePeriod(day: .friday, start: 3, end: 4, location: "情報工学系計算機室")
                ],
                year: 2022,
                quarters: [4],
                code: "CSC.T375",
                ocwId: "202202449",
                isForm8: false
            )
        )
    }
    
    func testParseReportCheckPageEn() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlEn = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultEnglish", withExtension: "html")!)
        
        let resultEn = try titechkyomu.parseReportCheckPage(html: htmlEn)
        XCTAssertEqual(
            resultEn[0],
            KyomuCourse(
                name: "Spectroscopy",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 11, end: 12, location: "S7-202(S000)"),
                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202")
                ],
                year: 2022,
                quarters: [1],
                code: "MAT.C302",
                ocwId: "202202171",
                isForm8: false
            )
        )
        XCTAssertFalse(resultEn.contains { $0.name == "Solid State Physics (Lattice)" })
        XCTAssertEqual(
            resultEn[6],
            KyomuCourse(
                name: "Introduction to Algorithms and Data Structures",
                periods: [],
                year: 2022,
                quarters: [2],
                code: "MCS.T213",
                ocwId: "202202382",
                isForm8: false
            )
        )
        XCTAssertEqual(
            resultEn[7],
            KyomuCourse(
                name: "Stochastic differential equations",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 3, end: 4, location: "W931"),
                    KyomuCoursePeriod(day: .friday, start: 3, end: 4, location: "W931")
                ],
                year: 2022,
                quarters: [4],
                code: "MCS.T419",
                ocwId: "202217437",
                isForm8: true
            )
        )
        XCTAssertEqual(
            resultEn[8],
            KyomuCourse(
                name: "Workshop on System Implementation",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 3, end: 4, location: "情報工学系計算機室"),
                    KyomuCoursePeriod(day: .friday, start: 3, end: 4, location: "情報工学系計算機室")
                ],
                year: 2022,
                quarters: [4],
                code: "CSC.T375",
                ocwId: "202202449",
                isForm8: false
            )
        )

    }
}
