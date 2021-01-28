import UIKit

enum ScoreStepperTag: Int {
    case onBlue
    case inBlue
    case onRed
    case inRed
}

protocol ScoreOutcomeDelegate: class {
    func updateScoreModel(for stepperTag: ScoreStepperTag, with newValue: Int)
}

class BagTossOutcomeSectionView: UIView {

    let blueOnLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.text = "On: 0"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()

    let blueOnStepper = ScoreStepper(frame: .zero, tag: ScoreStepperTag.onBlue.rawValue)

    let blueInLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.text = "In: 0"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()

    let blueInStepper = ScoreStepper(frame: .zero, tag: ScoreStepperTag.inBlue.rawValue)

    let redOnLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.text = "On: 0"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .systemRed
        return label
    }()

    let redOnStepper = ScoreStepper(frame: .zero, tag: ScoreStepperTag.onRed.rawValue)

    let redInLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero)
        label.text = "In: 0"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .systemRed
        return label
    }()

    let redInStepper = ScoreStepper(frame: .zero, tag: ScoreStepperTag.inRed.rawValue)

    weak var delegate: ScoreOutcomeDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 6
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        backgroundColor = UIColor(named: "contentBackgroundColor")
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews(
            blueOnLabel, blueOnStepper, blueInLabel, blueInStepper,
            redOnLabel, redOnStepper, redInLabel, redInStepper
        )

        configureViews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews() {
        for stepper in [blueOnStepper, blueInStepper, redOnStepper, redInStepper] {
            stepper.addTarget(self, action: #selector(didTapScoreStepper(sender:)), for: .valueChanged)
        }
    }

    func resetScoreSteppers() {
        blueOnLabel.text = "On: 0"
        blueInLabel.text = "In: 0"
        redOnLabel.text = "On: 0"
        redInLabel.text = "In: 0"
        for stepper in [blueOnStepper, blueInStepper, redOnStepper, redInStepper] {
            stepper.resetScoreSteppedToDefault()
        }
    }

    @objc func didTapScoreStepper(sender: UIStepper) {
        let newValue = Int(sender.value)
        switch sender.tag {
        case ScoreStepperTag.onBlue.rawValue:
            manageScoreStepperState(blueOnStepper, blueInStepper)
            delegate?.updateScoreModel(for: .onBlue, with: newValue)
        case ScoreStepperTag.inBlue.rawValue:
            manageScoreStepperState(blueOnStepper, blueInStepper)
            delegate?.updateScoreModel(for: .inBlue, with: newValue)
        case ScoreStepperTag.onRed.rawValue:
            manageScoreStepperState(redOnStepper, redInStepper)
            delegate?.updateScoreModel(for: .onRed, with: newValue)
        case ScoreStepperTag.inRed.rawValue:
            manageScoreStepperState(redOnStepper, redInStepper)
            delegate?.updateScoreModel(for: .inRed, with: newValue)
        default:
            break
        }
    }

    private func manageScoreStepperState(_ onStepper: UIStepper, _ inStepper: UIStepper) {
        let maxNumberOfTossesPerRound = 4.0
        onStepper.maximumValue = maxNumberOfTossesPerRound - inStepper.value
        inStepper.maximumValue = maxNumberOfTossesPerRound - onStepper.value
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            blueOnLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            blueOnLabel.centerXAnchor.constraint(equalTo: blueOnStepper.centerXAnchor),

            blueOnStepper.topAnchor.constraint(equalTo: blueOnLabel.bottomAnchor, constant: 8),
            blueOnStepper.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -24),

            blueInLabel.topAnchor.constraint(equalTo: blueOnStepper.bottomAnchor, constant: 16),
            blueInLabel.centerXAnchor.constraint(equalTo: blueInStepper.centerXAnchor),

            blueInStepper.topAnchor.constraint(equalTo: blueInLabel.bottomAnchor, constant: 8),
            blueInStepper.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -24),
            blueInStepper.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            redOnLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            redOnLabel.centerXAnchor.constraint(equalTo: redOnStepper.centerXAnchor),

            redOnStepper.topAnchor.constraint(equalTo: redOnLabel.bottomAnchor, constant: 8),
            redOnStepper.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 24),

            redInLabel.topAnchor.constraint(equalTo: redOnStepper.bottomAnchor, constant: 16),
            redInLabel.centerXAnchor.constraint(equalTo: redInStepper.centerXAnchor),

            redInStepper.topAnchor.constraint(equalTo: redInLabel.bottomAnchor, constant: 8),
            redInStepper.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 24),
            redInStepper.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])

    }

}
