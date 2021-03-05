import UIKit
import Kingfisher

class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newProductLabel: UIImageView!
    @IBOutlet weak var productImageView: URLImage!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!

    var product: ProductsModel? {
        didSet {
            guard let product = product else { return }

            productImageView.downloadImage(with: product.image) { [weak self] image in
                self?.productImageView.image = image
            }

            productTitleLabel.text = product.title
            productPriceLabel.text = product.productsPrice

            if product.isNewProduct {
                newProductLabel.isHidden = false
            } else {
                newProductLabel.isHidden = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = UIColor(hex: "#FFFFFF")

        addShadow(offset: .zero, color: .black, cornerRadius: 10, radius: 10, opacity: 0.05)

        productTitleLabel.adjustsFontSizeToFitWidth = true
    }

}
