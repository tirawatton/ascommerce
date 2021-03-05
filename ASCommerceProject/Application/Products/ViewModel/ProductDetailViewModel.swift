import Foundation

final class ProductDetailViewModel {
    private var service: ProductDetailServiceProtocol
    private var products: [ProductsModel] = [ProductsModel]()

    var product: ProductsModel? {
        didSet {
            self.reloadDataClosure?()
        }
    }

    var messageError: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    var reloadDataClosure: (()->())?
    var updateLoadingStatusClosure: (()->())?
    var showAlertClosure: (()->())?

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }

    init(service: ProductDetailServiceProtocol = ProductDetailService()) {
        self.service = service
    }

    func fetchProductDetail(at productId: Int) {
        isLoading = true
        service.fetchProdutDetailData(productId: productId) { [weak self] product in
            guard let self = self else { return }
            self.product = product
            self.isLoading = false
        } error: { err in
            self.messageError = "ไม่สามารถแสดงข้อมูลได้ขณะนี้"
        }
    }
}
