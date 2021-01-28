import UIKit

protocol MainMenuRouterType {
    func toMatchViewController(matchType: MatchType)
}

class MainMenuRouter: MainMenuRouterType {
    let routingViewController: MainMenuViewController

    init(viewController: MainMenuViewController) {
        self.routingViewController = viewController
    }

    func toMatchViewController(matchType: MatchType) {
        let newMatch = matchType == .single ? Match.generateSinglesTestMatch() : Match.generateDoublesTestMatch()
        let model = CurrentMatchModel(match: newMatch)
        let destinationViewController = CurrentMatchViewController()
        let router = CurrentMatchRouter(view: destinationViewController)
        let presenter = CurrentMatchPresenter(model: model, view: destinationViewController)
        destinationViewController.router = router
        destinationViewController.presenter = presenter
        destinationViewController.modalPresentationStyle = .fullScreen
        routingViewController.present(destinationViewController, animated: true)

        
    }
}
