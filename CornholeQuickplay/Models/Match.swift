import Foundation

enum MatchType: Int {
    case single, doubles

    var keyTitle: String {
        switch self {
        case .single:
            return "Single"
        case .doubles:
            return "Doubles"
        }
    }

    var totalAllowedPlayers: Int {
        switch self {
        case .single:
            return 2
        case .doubles:
            return 4
        }
    }
}

class Match {
    var date: Date = Date()
    var frames: [Frame] = []
    var redTeam: Team
    var blueTeam: Team
    var matchType: MatchType
    var winningTeam: TeamColor = .none
    var currentFrameNumber: Int = 1
    var currentPitcherIndex: Int {
        get {
            if self.matchType == .single {
                return 0
            } else {
                return self.currentFrameNumber % 2 == 0 ? 1 : 0
            }
        }
    }

    init(redTeam: Team, blueTeam: Team, matchType: MatchType) {
        self.redTeam = redTeam
        self.blueTeam = blueTeam
        self.matchType = matchType

        self.frames = []
    }

    func generateMatchSore(scoringTeam: TeamColor, points: Int) {
        switch scoringTeam {
        case .blue:
            blueTeam.score += points
        case .red:
            redTeam.score += points
        case .none:
            break
        }
    }

    func setWinningTeam() {
        let winningTeam: TeamColor = blueTeam.score >= 21 ? .blue : .red
        self.winningTeam = winningTeam
    }

    class func generateSinglesTestMatch() -> Match {
        let testMatch = Match(
            redTeam: Team(color: .red),
            blueTeam: Team(color: .blue),
            matchType: .single
        )

        testMatch.redTeam.players = [
            Pitcher(name: "Red One")
        ]

        testMatch.blueTeam.players = [
            Pitcher(name: "Blue One")
        ]

        return testMatch
    }

    class func generateDoublesTestMatch() -> Match {
        let testMatch = Match(
            redTeam: Team(color: .red),
            blueTeam: Team(color: .blue),
            matchType: .doubles
        )

        testMatch.redTeam.players = [
            Pitcher(name: "Red One"),
            Pitcher(name: "Red Two")
        ]

        testMatch.blueTeam.players = [
            Pitcher(name: "Blue One"),
            Pitcher(name: "Blue Two")
        ]

        return testMatch
    }
}
