import UIKit

class CHButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.borderWidth = 2
        layer.cornerRadius = 6
        layer.borderColor = UIColor.separator.cgColor
        setTitleColor(.label, for: .normal)
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
