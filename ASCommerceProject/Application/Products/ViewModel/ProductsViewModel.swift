import Foundation

final class ProductsViewModel {
    private var service: ProductsServiceProtocol
    private var products: [ProductsModel] = [ProductsModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }

    var product: ProductsModel?
    
    var reloadCollectionViewClosure: (() -> ())?
    var updateLoadingStatusClosure: (() -> ())?
    var showAlertClosure: (() -> ())?

    var messageError: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }

    init(service: ProductsServiceProtocol = ProductsService()) {
        self.service = service
    }

    func fetchProducts() {
        isLoading = true

        service.fetchProdutsData { [weak self] products in
            guard let self = self else { return }
            self.products = products
            self.isLoading = false
        } error: { err in
            self.messageError = "ไม่สามารถแสดงข้อมูลได้ขณะนี้"
        }
    }

    func getProductsData(at indexPath: IndexPath) -> ProductsModel {
        return products[indexPath.item]
    }

    func numberOfItems() -> Int {
        return products.count
    }
}
