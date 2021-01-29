@testable import CornholeQuickplay
import XCTest

class MatchTests: XCTestCase {

    var match: Match!

    override func setUp() {

        self.match = Match.generateSinglesTestMatch()
    }

    override func tearDown() {
        self.match = nil
    }

    func testGenerateMatchScore() {
        match.generateMatchSore(scoringTeam: .blue, points: 4)
        XCTAssertEqual(match.blueTeam.score, 4)
        match.generateMatchSore(scoringTeam: .red, points: 2)
        XCTAssertEqual(match.redTeam.score, 2)
        match.generateMatchSore(scoringTeam: .none, points: 0)
        XCTAssertEqual(match.blueTeam.score, 4)
        XCTAssertEqual(match.redTeam.score, 2)
    }

    func testSetWinningTeam() {
        match.blueTeam.score = 21
        match.setWinningTeam()
        XCTAssertEqual(match.winningTeam, .blue)
    }

}
