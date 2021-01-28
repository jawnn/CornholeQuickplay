import UIKit

protocol MatchResultPresenterType: UITableViewDataSource {
    func sendMatchScoreData()
}

protocol MatchResultViewType {
    func populateScoreBanner(redScore: Int, blueScore: Int)
}

enum MatchResultTableSections: Int, CaseIterable {
    case winningTeam
    case losingTeam
}

class MatchResultPresenter: NSObject, MatchResultPresenterType {

    var model: MatchResultModelType
    var view: MatchResultViewType

    init(model: MatchResultModelType, view: MatchResultViewType) {
        self.model = model
        self.view = view

    }

    func sendMatchScoreData() {
        view.populateScoreBanner(redScore: model.match.redTeam.score, blueScore: model.match.blueTeam.score)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return MatchResultTableSections.allCases.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case MatchResultTableSections.winningTeam.rawValue:
            return "\(model.winningTeam.color.title) Team"
        case MatchResultTableSections.losingTeam.rawValue:
            return "\(model.losingTeam.color.title) Team"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch model.match.matchType {
        case .single:
            return 1
        case .doubles:
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlayerRowCell.self)) as? PlayerRowCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case MatchResultTableSections.winningTeam.rawValue:
            cell.configurePlayerRow(with: model.winningTeam.players[indexPath.row], for: model.winningTeam.color.color)
        case MatchResultTableSections.losingTeam.rawValue:
            cell.configurePlayerRow(with: model.losingTeam.players[indexPath.row], for: model.losingTeam.color.color)
        default:
            break
        }
        
        return cell
    }

}
