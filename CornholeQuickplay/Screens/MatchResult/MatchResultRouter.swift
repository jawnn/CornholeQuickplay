import UIKit

protocol MatchResultRouterType {
    func toMainMenu()
    func toNewMatch()
}

class MatchResultRouter: MatchResultRouterType {
    var routingViewController: MatchResultViewController

    init(view: MatchResultViewController) {
        self.routingViewController = view
    }

    func toNewMatch() {
        guard let matchScreen = routingViewController.presentingViewController as? CurrentMatchViewController else {
            return
        }
        matchScreen.configureForRematch()
        routingViewController.dismiss(animated: true, completion: nil)
    }

    func toMainMenu() {
        guard let presentingVC = routingViewController.presentingViewController as? CurrentMatchViewController else {
            return
        }
        routingViewController.dismiss(animated: false) {
            presentingVC.dismiss(animated: false, completion: nil)
        }
    }
}
