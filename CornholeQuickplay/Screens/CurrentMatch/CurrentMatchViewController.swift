import UIKit

class CurrentMatchViewController: UIViewController {
    private weak var matchScoreSection: MatchScoreView!
    private weak var frameHistoryTableView: UITableView!
    private weak var bagTossOutcomeSectionView: BagTossOutcomeSectionView!
    private weak var completeRoundButton: CHButton!
    private weak var undoFrameButton: CHButton!
    private weak var resetMatchButton: CHButton!

    var router: CurrentMatchRouterType!
    var presenter: CurrentMatchPresenterType!

    override func loadView() {
        super.loadView()

        let matchScoreView = MatchScoreView(frame: .zero)
        let frameHistoryTableView = UITableView(frame: .zero)
        frameHistoryTableView.translatesAutoresizingMaskIntoConstraints = false
        let bagTossOutcomeSectionView = BagTossOutcomeSectionView(frame: .zero)
        let completeRoundButton = CHButton(frame: .zero)
        let undoFrameButton = CHButton(frame: .zero)
        let resetMatchButton = CHButton(frame: .zero)
        view.addSubviews(matchScoreView, frameHistoryTableView, bagTossOutcomeSectionView,
                         completeRoundButton, undoFrameButton, resetMatchButton
        )

        NSLayoutConstraint.activate([
            matchScoreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            matchScoreView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            matchScoreView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

            frameHistoryTableView.topAnchor.constraint(equalTo: matchScoreView.bottomAnchor, constant: 8),
            frameHistoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            frameHistoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            frameHistoryTableView.bottomAnchor.constraint(equalTo: bagTossOutcomeSectionView.topAnchor, constant: -8),

            bagTossOutcomeSectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            bagTossOutcomeSectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            bagTossOutcomeSectionView.bottomAnchor.constraint(equalTo: completeRoundButton.topAnchor, constant: -8),

            completeRoundButton.heightAnchor.constraint(equalToConstant: 44),
            completeRoundButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            completeRoundButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            completeRoundButton.bottomAnchor.constraint(equalTo: resetMatchButton.topAnchor, constant: -16),

            undoFrameButton.heightAnchor.constraint(equalToConstant: 44),
            undoFrameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            undoFrameButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -4),
            undoFrameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),

            resetMatchButton.heightAnchor.constraint(equalToConstant: 44),
            resetMatchButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 4),
            resetMatchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            resetMatchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])

        self.matchScoreSection = matchScoreView
        self.frameHistoryTableView = frameHistoryTableView
        self.bagTossOutcomeSectionView = bagTossOutcomeSectionView
        self.completeRoundButton = completeRoundButton
        self.undoFrameButton = undoFrameButton
        self.resetMatchButton = resetMatchButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureFrameHistoryTableView()
        presenter.sendNewFrameData()
        bagTossOutcomeSectionView.delegate = presenter
        configureRoundCompleteButton()
    }

    private func configureFrameHistoryTableView() {
        frameHistoryTableView.dataSource = presenter
        frameHistoryTableView.tableFooterView = UIView()
        frameHistoryTableView.separatorColor = .separator
        frameHistoryTableView.backgroundColor = .systemBackground
        frameHistoryTableView.register(FrameTableCell.self, forCellReuseIdentifier: String(describing: FrameTableCell.self))
    }

    private func configureRoundCompleteButton() {
        completeRoundButton.setTitle("Complete Round", for: .normal)
        completeRoundButton.addTarget(self, action: #selector(didTapCompleteRoundButton), for: .touchUpInside)

        undoFrameButton.setTitle("Undo Frame", for: .normal)
        undoFrameButton.addTarget(self, action: #selector(didTapUndoFrame), for: .touchUpInside)

        resetMatchButton.setTitle("Reset Match", for: .normal)
        resetMatchButton.addTarget(self, action: #selector(didTapResetMatch), for: .touchUpInside)

    }

    @objc func didTapUndoFrame() {
        let alertController = presenter.showUndoFrameAlertController()
        present(alertController, animated: true)
    }

    @objc func didTapResetMatch() {
        let alertController = presenter.showResetMatchAlertController()
        present(alertController, animated: true)
    }

    @objc func didTapCompleteRoundButton() {
        completeRoundButton.animateButtonTap()
        presenter.didTeamReachScoreLimit()
    }

}

extension CurrentMatchViewController: CurrentMatchViewType {

    func reloadFrameHistoryData() {
        frameHistoryTableView.reloadData()
    }

    func insertFrameRowAtTopOfTable() {
        frameHistoryTableView.beginUpdates()
        frameHistoryTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        frameHistoryTableView.endUpdates()
    }

    func removeFrameRowFromTopOfTable() {
        frameHistoryTableView.beginUpdates()
        frameHistoryTableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .left)
        frameHistoryTableView.endUpdates()
    }

    func updateScore(for stepper: ScoreStepperTag, with value: Int, frameScore: Int) {
        switch stepper {
        case .onBlue:
            bagTossOutcomeSectionView.blueOnLabel.text = "On: \(value)"
            matchScoreSection.blueFrameScoreLabel.text = "\(frameScore)"
        case .inBlue:
            bagTossOutcomeSectionView.blueInLabel.text = "In: \(value)"
            matchScoreSection.blueFrameScoreLabel.text = "\(frameScore)"
        case .onRed:
            bagTossOutcomeSectionView.redOnLabel.text = "On: \(value)"
            matchScoreSection.redFrameScoreLabel.text = "\(frameScore)"
        case .inRed:
            bagTossOutcomeSectionView.redInLabel.text = "In: \(value)"
            matchScoreSection.redFrameScoreLabel.text = "\(frameScore)"
        }
    }

    func populateViewsForNextFrame(bluePitcher bluePlayerName: String, redPitcher redPlayerName: String, blueTeam blueTeamMatchScore: Int, redTeam redTeamMatchScore: Int) {
        matchScoreSection.configureScoreLabelsForNextFrame(
            bluePlayerName: bluePlayerName,
            redPlayerName: redPlayerName,
            blueTeamMatchScore: blueTeamMatchScore,
            redTeamMatchScore: redTeamMatchScore
        )
        bagTossOutcomeSectionView.resetScoreSteppers()
    }

    func toMainMenu() {
        dismiss(animated: true)
    }

    func showMatchDetails() {
        router.showMatchResultsScreen(match: presenter.currentMatch)
    }

    func configureForRematch() {
        presenter.sendNewMatchData()
    }

}
