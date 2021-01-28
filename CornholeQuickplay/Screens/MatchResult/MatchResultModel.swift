import Foundation

protocol MatchResultModelType {
    var match: Match { get }
    var winningTeam: Team { get }
    var losingTeam: Team { get }
}

class MatchResultModel: MatchResultModelType {

    var match: Match
    var losingTeam: Team
    var winningTeam: Team

    init(match: Match) {
        self.match = match
        self.losingTeam = match.winningTeam == .blue ? match.redTeam : match.blueTeam
        self.winningTeam = match.winningTeam == .red ? match.redTeam : match.blueTeam
    }

}
