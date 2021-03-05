import Foundation

protocol ProductDetailServiceProtocol {
    func fetchProdutDetailData(productId: Int, completion: @escaping (ProductsModel) -> Void, error: @escaping (APIError) -> Void)
}

class ProductDetailService: ProductDetailServiceProtocol {
    func fetchProdutDetailData(productId: Int, completion: @escaping (ProductsModel) -> Void, error: @escaping (APIError) -> Void) {
        APIRequest.shared.requestProductDetailData(productId: productId) { result in
            switch result {
            case .success(let products):
                completion(products)
            case .failure(let err):
                error(err)
            }
        }
    }
}

