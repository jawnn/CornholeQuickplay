import UIKit

class MatchResultViewController: UIViewController {

    weak var finalScoreBanner: FinalScoreBanner!
    weak var tableView: UITableView!
    private weak var mainMenuButton: CHButton!
    private weak var playAgainButton: CHButton!

    var presenter: MatchResultPresenterType!
    var router: MatchResultRouterType!

    override func loadView() {
        super.loadView()

        let finalScoreBanner = FinalScoreBanner(frame: .zero)
        let mainMenuButton = CHButton(frame: .zero)
        let playAgainButton = CHButton(frame: .zero)
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews(finalScoreBanner, tableView, mainMenuButton, playAgainButton)

        NSLayoutConstraint.activate([
            finalScoreBanner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            finalScoreBanner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            finalScoreBanner.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            tableView.topAnchor.constraint(equalTo: finalScoreBanner.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            mainMenuButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            mainMenuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            mainMenuButton.heightAnchor.constraint(equalToConstant: 44),
            mainMenuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36),

            playAgainButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            playAgainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            playAgainButton.heightAnchor.constraint(equalToConstant: 44),
            playAgainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36),
        ])

        self.finalScoreBanner = finalScoreBanner
        self.tableView = tableView
        self.mainMenuButton = mainMenuButton
        self.playAgainButton = playAgainButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "screenBackgroundColor")
        configureNavigationButtons()
        configureResultsTableView()
        presenter.sendMatchScoreData()
    }

    func configureResultsTableView() {
        tableView.dataSource = presenter
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor(named: "screenBackgroundColor")
        tableView.register(PlayerRowCell.self, forCellReuseIdentifier: String(describing: PlayerRowCell.self))
    }

    func configureNavigationButtons() {
        mainMenuButton.setTitle("Main Menu", for: .normal)
        mainMenuButton.addTarget(self, action: #selector(didTapGoToMainMenu), for: .touchUpInside)

        playAgainButton.setTitle("Play again", for: .normal)
        playAgainButton.addTarget(self, action: #selector(didTapPlayAgain), for: .touchUpInside)
    }

    @objc func didTapGoToMainMenu() {
        router.toMainMenu()
    }

    @objc func didTapPlayAgain() {
        router.toNewMatch()
    }

}

extension MatchResultViewController: MatchResultViewType {
    func populateScoreBanner(redScore: Int, blueScore: Int) {
        finalScoreBanner.configureViewContent(redScore: redScore, blueScore: blueScore)
    }
}
