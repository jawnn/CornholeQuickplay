import UIKit

class FinalScoreBanner: UIView {
    let blueTeamIcon: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let blueMatchScoreLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .systemBlue
        label.textAlignment = .center
        return label
    }()

    let matchScoreLineDivider: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.text = "FINAL"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    let redMatchScoreLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .systemRed
        label.textAlignment = .center
        return label
    }()

    let redTeamIcon: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.separator.cgColor
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews(
            blueTeamIcon, blueMatchScoreLabel,
            matchScoreLineDivider,
            redMatchScoreLabel, redTeamIcon
        )

        configureViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureViewContent(redScore: Int, blueScore: Int) {
        redMatchScoreLabel.text = "\(redScore)"
        blueMatchScoreLabel.text = "\(blueScore)"
    }

    private func configureViewConstraints() {
        NSLayoutConstraint.activate([
            blueTeamIcon.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            blueTeamIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            blueTeamIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            blueTeamIcon.heightAnchor.constraint(equalToConstant: 32),
            blueTeamIcon.widthAnchor.constraint(equalToConstant: 32),

            blueMatchScoreLabel.leadingAnchor.constraint(equalTo: blueTeamIcon.trailingAnchor, constant: 16),
            blueMatchScoreLabel.centerYAnchor.constraint(equalTo: blueTeamIcon.centerYAnchor),

            matchScoreLineDivider.centerXAnchor.constraint(equalTo: centerXAnchor),
            matchScoreLineDivider.centerYAnchor.constraint(equalTo: blueTeamIcon.centerYAnchor),

            redMatchScoreLabel.trailingAnchor.constraint(equalTo: redTeamIcon.leadingAnchor, constant: -16),
            redMatchScoreLabel.centerYAnchor.constraint(equalTo: redTeamIcon.centerYAnchor),

            redTeamIcon.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            redTeamIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            redTeamIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            redTeamIcon.heightAnchor.constraint(equalToConstant: 32),
            redTeamIcon.widthAnchor.constraint(equalToConstant: 32),
        ])
    }

}
