import Foundation

protocol MatchResultModelType {
    var match: Match { get set }
    var winningTeam: Team { get set }
    var losingTeam: Team { get set }
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
