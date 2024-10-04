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
                name: "世界を知る：南・東南アジア",
                periods: [
                    KyomuCoursePeriod(day: .wednesday, start: 3, end: 4, location: ""),
                ],
                year: 2024,
                quarters: [3],
                code: "LAH.A505",
                ocwId: "202403782",
                teachers: ["※田中 李歩"],
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[1],
            KyomuCourse(
                name: "半導体物性特論（材料）",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 1, end: 2, location: "J2-303(J234)"),
                    KyomuCoursePeriod(day: .friday, start: 1, end: 2, location: "J2-303(J234)"),
                ],
                year: 2024,
                quarters: [3],
                code: "ESI.J442.L (MAT.C404)",
                ocwId: "202402959",
                teachers: ["真島 豊, 平松 秀典"],
                isForm8: true // Check Form8
            )
        )
        
        // 特許の科目をNGに
        XCTAssertFalse(resultJa.contains { $0.name == "知的情報資源の活用と特許" })

        
        XCTAssertEqual(
            resultJa[5],
            KyomuCourse(
                name: "エネルギーイノベーション協創プロジェクト",
                periods: [
                    // 時間指定なし
                ],
                year: 2024,
                quarters: [3, 4],
                code: "ESI.B502",
                ocwId: "202404150",
                teachers: ["コース主任, 渡部 卓雄, 難波江 裕太"],
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
                name: "Area Studies: South and Southeast Asia",
                periods: [
                    KyomuCoursePeriod(day: .wednesday, start: 3, end: 4, location: ""),
                ],
                year: 2024,
                quarters: [3],
                code: "LAH.A505",
                ocwId: "202403782",
                teachers: ["※Tanaka Riho"],
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[1],
            KyomuCourse(
                name: "Physics and Chemistry of Semiconductors",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 1, end: 2, location: "J2-303(J234)"),
                    KyomuCoursePeriod(day: .friday, start: 1, end: 2, location: "J2-303(J234)"),
                ],
                year: 2024,
                quarters: [3],
                code: "ESI.J442.L (MAT.C404)",
                ocwId: "202402959",
                teachers: ["Majima Yutaka, Hiramatsu Hidenori"],
                isForm8: true // Check Form8
            )
        )
        
        // 特許の科目をNGに
        XCTAssertFalse(resultEn.contains { $0.name == "Utilization of Intelligent Information Resources and Patents" })

        
        XCTAssertEqual(
            resultEn[5],
            KyomuCourse(
                name: "Energy innovation co-creative project",
                periods: [
                    // 時間指定なし
                ],
                year: 2024,
                quarters: [3, 4],
                code: "ESI.B502",
                ocwId: "202404150",
                teachers: ["Head, Watanabe Takuo, Nabae Yuta"],
                isForm8: false
            )
        )

    }
    
}
