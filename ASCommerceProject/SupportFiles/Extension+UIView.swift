import UIKit

extension UIView {
    func addShadow(offset: CGSize, color: UIColor, cornerRadius: CGFloat, radius: CGFloat, opacity: Float) {
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
