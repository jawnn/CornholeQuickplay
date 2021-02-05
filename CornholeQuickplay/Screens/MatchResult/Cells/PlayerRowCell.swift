import UIKit

class PlayerRowCell: UITableViewCell {

    let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let playerNameColLabel: PaddedLabel = {
        let label = PaddedLabel(frame: .zero, 0, 8, 8, 0)
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    let cellBackgroundColorview: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        layoutCellBackgroundColorView()
        layoutRowStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutCellBackgroundColorView() {
        contentView.addSubview(cellBackgroundColorview)
        NSLayoutConstraint.activate([
            cellBackgroundColorview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cellBackgroundColorview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cellBackgroundColorview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cellBackgroundColorview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

    private func layoutRowStackView() {
        cellBackgroundColorview.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cellBackgroundColorview.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: cellBackgroundColorview.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: cellBackgroundColorview.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: cellBackgroundColorview.bottomAnchor),
        ])
    }

    func configurePlayerRow(with pitcher: Pitcher, for teamColor: UIColor) {
        playerNameColLabel.text = pitcher.name
        playerNameColLabel.backgroundColor = teamColor
        cellBackgroundColorview.layer.borderColor = teamColor.cgColor

        stackView.addArrangedSubview(playerNameColLabel)
        NSLayoutConstraint.activate([
            playerNameColLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            playerNameColLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            playerNameColLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            playerNameColLabel.widthAnchor.constraint(equalToConstant: 100),
            playerNameColLabel.heightAnchor.constraint(equalToConstant: 60),
        ])

        let totalInOnRow = layoutColumnStackView(header: "In/On", value: "\(pitcher.totalCornholes) / \(pitcher.totalOnBoard)")
        let avgeragePointsPerRoundRow = layoutColumnStackView(header: "Round Avg.", value: String(format: "%.2f", pitcher.averageScore))
        let deltaRow = layoutColumnStackView(header: "+/-", value: "\(pitcher.matchPlusMinus)")

        let statStackView = UIStackView(frame: .zero)
        statStackView.spacing = 4
        statStackView.axis = .horizontal
        statStackView.alignment = .center
        statStackView.distribution = .fillEqually

        statStackView.addArrangedSubview(totalInOnRow)
        statStackView.addArrangedSubview(avgeragePointsPerRoundRow)
        statStackView.addArrangedSubview(deltaRow)
        stackView.addArrangedSubview(statStackView)
    }

    func layoutColumnStackView(header: String, value: String) -> UIStackView {
        let colStackView = UIStackView()
        colStackView.spacing = 4
        colStackView.axis = .vertical
        colStackView.alignment = .center
        colStackView.distribution = .fillEqually

        let headerLabel = PaddedLabel(frame: .zero)
        headerLabel.textColor = .label
        headerLabel.font = .systemFont(ofSize: 14, weight: .regular)
        headerLabel.text = header.uppercased()

        let valueLabel = PaddedLabel(frame: .zero)
        valueLabel.textColor = .label
        valueLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        valueLabel.text = value

        colStackView.addArrangedSubview(headerLabel)
        colStackView.addArrangedSubview(valueLabel)
        return colStackView
    }

    override func prepareForReuse() {
        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

}
