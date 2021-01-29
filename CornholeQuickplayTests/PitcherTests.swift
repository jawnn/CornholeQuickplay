@testable import CornholeQuickplay
import XCTest

class PitcherTests: XCTestCase {

    var pitcher: Pitcher!

    override func setUp() {
        self.pitcher = Pitcher(name: "Blue guy")
    }

    override func tearDown() {
        self.pitcher = nil
    }

    func testIncrementStats() {
        var frame1 = FrameStat(pitcher: pitcher)
        frame1.onBoard = 2
        frame1.cornholes = 1
        pitcher.incrementStats(with: frame1)

        var frame2 = FrameStat(pitcher: pitcher)
        frame2.onBoard = 2
        frame2.cornholes = 1
        pitcher.incrementStats(with: frame1)

        XCTAssertEqual(pitcher.totalOnBoard, 4)
        XCTAssertEqual(pitcher.totalCornholes, 2)
        XCTAssertEqual(pitcher.totalOffBoard, 2)
        XCTAssertEqual(pitcher.totalScore, 10)
        XCTAssertEqual(pitcher.frames.count, 2)
        XCTAssertEqual(pitcher.averageScore, 5)

        pitcher.decrementStats(with: frame2)

        XCTAssertEqual(pitcher.totalOnBoard, 2)
        XCTAssertEqual(pitcher.totalCornholes, 1)
        XCTAssertEqual(pitcher.totalOffBoard, 1)
        XCTAssertEqual(pitcher.totalScore, 5)
        XCTAssertEqual(pitcher.frames.count, 1)
    }

    func testDecrementStats() {
        var frame = FrameStat(pitcher: pitcher)
        frame.onBoard = 2
        frame.cornholes = 1

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
