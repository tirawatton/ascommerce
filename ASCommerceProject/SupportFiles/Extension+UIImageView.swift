import UIKit
import Kingfisher

extension UIImageView {
    func addShadow(shadowSize: CGFloat, shadowDistance: CGFloat, color: UIColor, radius: CGFloat, opacity: Float) {
        let contactRect = CGRect(x: shadowSize, y: self.frame.height - (shadowSize * 0.4) + shadowDistance, width: self.frame.width - shadowSize * 2, height: shadowSize)
        layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
