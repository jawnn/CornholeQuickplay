@testable import CornholeQuickplay
import XCTest

class FrameTests: XCTestCase {

    var frame: Frame!
    var bluePitcher: Pitcher!
    var redPitcher: Pitcher!

    override func setUp() {
        self.redPitcher = Pitcher(name: "red")
        self.bluePitcher = Pitcher(name: "blue")
        self.frame = Frame(frame: 1, bluePitcher: FrameStat(pitcher: bluePitcher), redPitcher: FrameStat(pitcher: redPitcher))
    }

    override func tearDown() {
        self.frame = nil
        self.bluePitcher = nil
        self.redPitcher = nil
    }

    func testGeneratePlusMinus() {
        // Test Red Score
        frame.scoringTeam = .red
        frame.blueFrame.plusMinus = -2
        frame.redFrame.plusMinus = 2
        let shouldBeTwo = frame.generatePlusMinus()
        XCTAssertEqual(shouldBeTwo, 2)

        // Test Blue Score
        frame.scoringTeam = .blue
        frame.blueFrame.plusMinus = 4
        frame.redFrame.plusMinus = -4
        let shouldBeFour = frame.generatePlusMinus()
        XCTAssertEqual(shouldBeFour, 4)

        // Test Wash
        frame.scoringTeam = .none
        frame.blueFrame.plusMinus = 0
        frame.redFrame.plusMinus = 0
        let shouldBeZero = frame.generatePlusMinus()
        XCTAssertEqual(shouldBeZero, 0)
    }

    func testGenerateFrameScore() {
        // Test Blue
        frame.blueFrame.cornholes = 2
        let shouldBeSix = frame.generateFrameScore()
        XCTAssertEqual(frame.blueFrame.plusMinus, 6)
        XCTAssertEqual(frame.redFrame.plusMinus, -6)
        XCTAssertEqual(frame.scoringTeam, .blue)
        XCTAssertEqual(shouldBeSix, 6)

        // Test Red
        resetFrameForNextCondition()
        frame.redFrame.cornholes = 1
        let shouldBeThree = frame.generateFrameScore()
        XCTAssertEqual(frame.blueFrame.plusMinus, -3)
        XCTAssertEqual(frame.redFrame.plusMinus, 3)
        XCTAssertEqual(frame.scoringTeam, .red)
        XCTAssertEqual(shouldBeThree, 3)

        // Test Wash
        resetFrameForNextCondition()
        let shouldBeZero = frame.generateFrameScore()
        XCTAssertEqual(frame.scoringTeam, .none)
        XCTAssertEqual(shouldBeZero, 0)
    }

    func testFrameStatCalculatedValues() {
        frame.blueFrame.onBoard = 2
        XCTAssertEqual(frame.blueFrame.offBoard, 2)
        XCTAssertEqual(frame.blueFrame.score, 2)
        frame.redFrame.cornholes = 1
        frame.redFrame.onBoard = 1
        XCTAssertEqual(frame.redFrame.offBoard, 2)
        XCTAssertEqual(frame.redFrame.score, 4)

        resetFrameForNextCondition()
        frame.blueFrame.cornholes = 4
        XCTAssertEqual(frame.blueFrame.offBoard, 0)
        XCTAssertEqual(frame.redFrame.offBoard, 4)
    }

    // MARK: - Helpers

    func resetFrameForNextCondition() {
        frame.blueFrame.onBoard = 0
        frame.blueFrame.cornholes = 0
        frame.blueFrame.plusMinus = 0
        frame.redFrame.onBoard = 0
        frame.redFrame.cornholes = 0
        frame.redFrame.plusMinus = 0
    }

}
