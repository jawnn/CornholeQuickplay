import UIKit

protocol CurrentMatchRouterType {
    func showMatchResultsScreen(match: Match)
}

class CurrentMatchRouter: CurrentMatchRouterType {
    let routingViewController: CurrentMatchViewController

    init(view: CurrentMatchViewController) {
        self.routingViewController = view
    }

    func showMatchResultsScreen(match: Match) {
        let model = MatchResultModel(match: match)
        let destinationViewController = MatchResultViewController()
        let router = MatchResultRouter(view: destinationViewController)
        destinationViewController.router = router
        let presenter = MatchResultPresenter(model: model, view: destinationViewController)
        destinationViewController.presenter = presenter
        destinationViewController.modalPresentationStyle = .fullScreen
        routingViewController.present(destinationViewController, animated: true)
    }
}
