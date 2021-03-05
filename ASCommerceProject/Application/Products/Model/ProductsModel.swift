import UIKit
import Kingfisher

struct ProductsModel: Decodable {
    var id: Int
    var title: String
    var image: String
    var content: String
    var isNewProduct: Bool
    var price: Float

    var productsPrice: String {
        return "\(price)"
    }
}
