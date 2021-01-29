import UIKit

class MainMenuViewController: UIViewController {

    private var titleLabel = PaddedLabel(frame: .zero)
    private var singlesButton = CHButton(frame: .zero)
    private var doublesButton = CHButton(frame: .zero)

    var router: MainMenuRouterType!

    override func loadView() {
        super.loadView()

        view.addSubviews(titleLabel, singlesButton, doublesButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),

            singlesButton.heightAnchor.constraint(equalToConstant: 44),
            singlesButton.widthAnchor.constraint(equalToConstant: 120),
            singlesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            singlesButton.bottomAnchor.constraint(equalTo: doublesButton.topAnchor, constant: -24),

            doublesButton.heightAnchor.constraint(equalToConstant: 44),
            doublesButton.widthAnchor.constraint(equalToConstant: 120),
            doublesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doublesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "screenBackgroundColor")
        configureTitleLabel()
        configureGameModeButtons()
    }

    private func configureTitleLabel() {
        titleLabel.layer.cornerRadius = 6
        titleLabel.layer.borderWidth = 2
        titleLabel.layer.borderColor = UIColor.gray.cgColor
        titleLabel.backgroundColor = UIColor(named: "contentBackgroundColor")
        titleLabel.text = "CORNHOLE QUICKPLAY"
        titleLabel.textColor = UIColor(named: "textColor")
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.minimumScaleFactor = 0.7
        titleLabel.font = .systemFont(ofSize: 64, weight: .semibold)
    }

    private func configureGameModeButtons() {
        singlesButton.tag = MatchType.single.rawValue
        singlesButton.setTitle(MatchType.single.keyTitle, for: .normal)
        singlesButton.addTarget(self, action: #selector(didTapGameModeButton(sender:)), for: .touchUpInside)

        doublesButton.tag = MatchType.doubles.rawValue
        doublesButton.setTitle(MatchType.doubles.keyTitle, for: .normal)
        doublesButton.addTarget(self, action: #selector(didTapGameModeButton(sender:)), for: .touchUpInside)
    }

    @objc func didTapGameModeButton(sender: UIButton) {
        switch sender.tag {
        case MatchType.single.rawValue:
            sender.animateButtonTap()
            router.toMatchViewController(matchType: MatchType.single)
        case MatchType.doubles.rawValue:
            sender.animateButtonTap()
            router.toMatchViewController(matchType: MatchType.doubles)
        default:
            break
        }
    }


}

