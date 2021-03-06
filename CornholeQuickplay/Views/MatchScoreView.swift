import UIKit

class MatchScoreView: UIView {

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
        label.text = "Match Score"
        label.font = .systemFont(ofSize: 24, weight: .regular)
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

    let bluePitcherNameLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    let blueFrameScoreLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .systemBlue
        label.textAlignment = .center
        return label
    }()

    let frameScoreLineDivider: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.text = "Frame Score"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    let redFrameScoreLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .systemRed
        label.textAlignment = .center
        return label
    }()

    let redPitcherNameLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 2
        layer.cornerRadius = 6
        layer.borderColor = UIColor.separator.cgColor
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews(
            blueTeamIcon, blueMatchScoreLabel, matchScoreLineDivider, redMatchScoreLabel, redTeamIcon,
            bluePitcherNameLabel, blueFrameScoreLabel, frameScoreLineDivider, redFrameScoreLabel, redPitcherNameLabel
            )

        configureViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureScoreLabelsForNextFrame(bluePlayerName: String, redPlayerName: String, blueTeamMatchScore: Int, redTeamMatchScore: Int) {
        redFrameScoreLabel.text = "0"
        redPitcherNameLabel.text = redPlayerName
        redMatchScoreLabel.text = "\(redTeamMatchScore)"

        blueFrameScoreLabel.text = "0"
        bluePitcherNameLabel.text = bluePlayerName
        blueMatchScoreLabel.text = "\(blueTeamMatchScore)"
    }

    private func configureViewConstraints() {

        NSLayoutConstraint.activate([
            blueTeamIcon.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            blueTeamIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            blueTeamIcon.bottomAnchor.constraint(equalTo: bluePitcherNameLabel.topAnchor, constant: -16),
            blueTeamIcon.heightAnchor.constraint(equalToConstant: 32),
            blueTeamIcon.widthAnchor.constraint(equalToConstant: 32),

            blueMatchScoreLabel.leadingAnchor.constraint(equalTo: blueTeamIcon.trailingAnchor, constant: 16),
            blueMatchScoreLabel.centerYAnchor.constraint(equalTo: blueTeamIcon.centerYAnchor),

            matchScoreLineDivider.centerXAnchor.constraint(equalTo: centerXAnchor),
            matchScoreLineDivider.centerYAnchor.constraint(equalTo: blueTeamIcon.centerYAnchor),

            redMatchScoreLabel.trailingAnchor.constraint(equalTo: redTeamIcon.leadingAnchor, constant: -16),
            redMatchScoreLabel.centerYAnchor.constraint(equalTo: redTeamIcon.centerYAnchor),

            redTeamIcon.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            redTeamIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            redTeamIcon.bottomAnchor.constraint(equalTo: redPitcherNameLabel.topAnchor, constant: -16),
            redTeamIcon.heightAnchor.constraint(equalToConstant: 32),
            redTeamIcon.widthAnchor.constraint(equalToConstant: 32),

            bluePitcherNameLabel.leadingAnchor.constraint(equalTo: blueTeamIcon.trailingAnchor, constant: 4),
            bluePitcherNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            blueFrameScoreLabel.leadingAnchor.constraint(equalTo: bluePitcherNameLabel.trailingAnchor, constant: 16),
            blueFrameScoreLabel.centerYAnchor.constraint(equalTo: bluePitcherNameLabel.centerYAnchor),

            frameScoreLineDivider.centerXAnchor.constraint(equalTo: centerXAnchor),
            frameScoreLineDivider.centerYAnchor.constraint(equalTo: redPitcherNameLabel.centerYAnchor),

            redFrameScoreLabel.trailingAnchor.constraint(equalTo: redPitcherNameLabel.leadingAnchor, constant: -16),
            redFrameScoreLabel.centerYAnchor.constraint(equalTo: redPitcherNameLabel.centerYAnchor),

            redPitcherNameLabel.trailingAnchor.constraint(equalTo: redTeamIcon.leadingAnchor, constant: -4),
            redPitcherNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])

    }

}
