import UIKit

extension UIButton {

    func animateButtonTap() {
        UIView.animateKeyframes(withDuration: 0.10, delay: 0, options: [.autoreverse]) {
            self.alpha = 0.50
        } completion: { _ in
            self.alpha = 1
        }

    }

}
