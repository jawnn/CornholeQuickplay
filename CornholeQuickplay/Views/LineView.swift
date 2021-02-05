import UIKit

class LineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .tertiarySystemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
