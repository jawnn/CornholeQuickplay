@testable import CornholeQuickplay
import XCTest

class PitcherTests: XCTestCase {

    var pitcher: Pitcher!

    override func setUp() {
        self.pitcher = Pitcher(name: "Blue guy")
    }

    override func tearDown() {

    }

    func testIncrementStats() {
        var frame = FrameStat(pitcher: pitcher)
        frame.onBoard = 2
        frame.cornholes = 1
        pitcher.incrementStats(with: frame)

        XCTAssertEqual(pitcher.totalOnBoard, 2)
        XCTAssertEqual(pitcher.totalCornholes, 1)
        XCTAssertEqual(pitcher.totalOffBoard, 1)
        XCTAssertEqual(pitcher.totalScore, 5)
        XCTAssertEqual(pitcher.frames.count, 1)
        XCTAssertEqual(pitcher.averageScore, 5)
    }

    func testPitchersCalculatedValues() {
        var frame1 = FrameStat(pitcher: pitcher)
        frame1.cornholes = 2
        frame1.onBoard = 1

        var frame2 = FrameStat(pitcher: pitcher)
        frame2.cornholes = 0
        frame2.onBoard = 3

        pitcher.incrementStats(with: frame1)
        pitcher.incrementStats(with: frame2)

        XCTAssertEqual(pitcher.averageScore, 5)
    }

}
