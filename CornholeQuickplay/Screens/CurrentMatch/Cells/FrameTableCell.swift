import UIKit

class FrameTableCell: UITableViewCell {

    let blueTeamIcon: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bluePitcherLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    let blueScoreLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    let blueWinArrowView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "arrowtriangle.left.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let redTeamIcon: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let redPitcherLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    let redScoreLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    let redWinArrowView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "arrowtriangle.left.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let dividerView = LineView(frame: .zero)

    let frameNumberLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    let frameOutcomeLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: String(describing: FrameTableCell.self))
        selectionStyle = .none
        contentView.backgroundColor = UIColor(named: "contentBackgroundColor")
        configureSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        contentView.addSubviews(
            blueTeamIcon, bluePitcherLabel, redTeamIcon, redPitcherLabel,
            blueScoreLabel, blueWinArrowView, redScoreLabel, redWinArrowView,
            dividerView, frameNumberLabel, frameOutcomeLabel
        )
        configureConstraints()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            blueTeamIcon.widthAnchor.constraint(equalToConstant: 16),
            blueTeamIcon.heightAnchor.constraint(equalToConstant: 16),
            blueTeamIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            blueTeamIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            blueTeamIcon.bottomAnchor.constraint(equalTo: redTeamIcon.topAnchor, constant: -6),

            bluePitcherLabel.centerYAnchor.constraint(equalTo: blueTeamIcon.centerYAnchor),
            bluePitcherLabel.leadingAnchor.constraint(equalTo: blueTeamIcon.trailingAnchor, constant: 16),

            redTeamIcon.widthAnchor.constraint(equalToConstant: 16),
            redTeamIcon.heightAnchor.constraint(equalToConstant: 16),
            redTeamIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            redTeamIcon.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -6),

            redPitcherLabel.centerYAnchor.constraint(equalTo: redTeamIcon.centerYAnchor),
            redPitcherLabel.leadingAnchor.constraint(equalTo: redTeamIcon.trailingAnchor, constant: 16),

            blueScoreLabel.centerYAnchor.constraint(equalTo: blueTeamIcon.centerYAnchor),
            blueScoreLabel.trailingAnchor.constraint(equalTo: blueWinArrowView.leadingAnchor, constant: -6),

            blueWinArrowView.widthAnchor.constraint(equalToConstant: 16),
            blueWinArrowView.heightAnchor.constraint(equalToConstant: 16),
            blueWinArrowView.centerYAnchor.constraint(equalTo: blueTeamIcon.centerYAnchor),
            blueWinArrowView.trailingAnchor.constraint(equalTo: dividerView.leadingAnchor, constant: -4),

            redScoreLabel.centerYAnchor.constraint(equalTo: redTeamIcon.centerYAnchor),
            redScoreLabel.trailingAnchor.constraint(equalTo: redWinArrowView.leadingAnchor, constant: -6),

            redWinArrowView.widthAnchor.constraint(equalToConstant: 16),
            redWinArrowView.heightAnchor.constraint(equalToConstant: 16),
            redWinArrowView.centerYAnchor.constraint(equalTo: redTeamIcon.centerYAnchor),
            redWinArrowView.trailingAnchor.constraint(equalTo: dividerView.leadingAnchor, constant: -4),

            dividerView.widthAnchor.constraint(equalToConstant: 1),
            dividerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dividerView.trailingAnchor.constraint(equalTo: frameNumberLabel.leadingAnchor, constant: -8),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            frameNumberLabel.widthAnchor.constraint(equalToConstant: 75),
            frameNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            frameNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            frameNumberLabel.bottomAnchor.constraint(equalTo: frameOutcomeLabel.topAnchor, constant: -6),

            frameOutcomeLabel.leadingAnchor.constraint(equalTo: frameNumberLabel.leadingAnchor),
            frameOutcomeLabel.bottomAnchor.constraint(equalTo: redTeamIcon.bottomAnchor)
        ])
    }

    func layoutViewConfigurations(scoringTeam: TeamColor) {
        frameOutcomeLabel.textColor = scoringTeam.color

        redWinArrowView.isHidden = scoringTeam != .red ? true : false
        redScoreLabel.textColor = scoringTeam == .red ? UIColor(named: "textColor") : .systemGray
        redPitcherLabel.textColor = scoringTeam == .red ? UIColor(named: "textColor") : .systemGray

        blueWinArrowView.isHidden = scoringTeam != .blue ? true : false
        blueScoreLabel.textColor = scoringTeam == .blue ? UIColor(named: "textColor") : .systemGray
        bluePitcherLabel.textColor = scoringTeam == .blue ? UIColor(named: "textColor") : .systemGray
    }

    override func prepareForReuse() {
        redWinArrowView.isHidden = false
        blueWinArrowView.isHidden = false
        for label in [redScoreLabel, redPitcherLabel, blueScoreLabel, bluePitcherLabel] {
            label.textColor = UIColor(named: "textColor")
        }
    }
}
