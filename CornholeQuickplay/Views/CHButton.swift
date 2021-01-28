import UIKit

class CHButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.borderWidth = 2
        layer.cornerRadius = 6
        layer.borderColor = UIColor.gray.cgColor
        setTitleColor(UIColor(named: "textColor"), for: .normal)
        backgroundColor = UIColor(named: "contentBackgroundColor")
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
