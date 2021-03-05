import Foundation

protocol ProductsServiceProtocol {
    func fetchProdutsData(completion: @escaping ([ProductsModel]) -> Void, error: @escaping (APIError) -> Void)
}

class ProductsService: ProductsServiceProtocol {
    func fetchProdutsData(completion: @escaping ([ProductsModel]) -> Void, error: @escaping (APIError) -> Void) {
        APIRequest.shared.requestProductsData { result in
            switch result {
            case .success(let products):
                completion(products)
            case .failure(let err):
                error(err)
            }
        }
    }
}
