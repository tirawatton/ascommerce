import UIKit

extension UICollectionViewCell {
    // The @objc is added to silence the complier errors
    @objc class var identifier: String {
        return String(describing: self)
    }
}
