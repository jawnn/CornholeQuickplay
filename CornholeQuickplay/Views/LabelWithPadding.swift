import UIKit

class PaddedLabel: UILabel {

    var paddingInsets: UIEdgeInsets

    init(frame: CGRect, _ top: CGFloat = 0, _ left: CGFloat = 0, _ right: CGFloat = 0, _ bottom: CGFloat = 0) {
        self.paddingInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: paddingInsets))
    }

}
