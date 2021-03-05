import XCTest
@testable import ASCommerceProject

class ProductDetailViewControllerTests: XCTestCase {

    var viewController: ProductDetailViewController!

    override func setUp() {
        super.setUp()
        let viewController = ProductDetailViewController.instantiate(for: ProductDetailViewModel(), toSet: 2)
        _ = viewController.view

        self.viewController = viewController
    }

    override func tearDown() {
        super.tearDown()
        viewController = nil
    }

    func testProductDetailIsAppear() {
        mockRequestProductDetailSuccess()

        viewController.setupProductDetail()

        let productDetailTitle = self.viewController.productTitleLabel.text
        let productDetailPrice = self.viewController.productPriceLabel.text
        let productDetailContent = self.viewController.productContentLabel.text
        let newProductDetail = self.viewController.productContentLabel.isHidden

        XCTAssertEqual(productDetailTitle, "Signature Chocolate Chip Lactation Cookies")
        XCTAssertEqual(productDetailPrice, "18.569")
        XCTAssertEqual(productDetailContent, "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
        XCTAssertFalse(newProductDetail)
    }

    private func mockRequestProductDetailSuccess() {
        let response = productDetailData()
        APIRequest.shared = MockNetwork(responseData: response)

        viewController.viewDidLoad()
    }

    private func productDetailData() -> ProductsModel {
        let mockItems =  ProductsModel(id: 2,
                                       title: "Signature Chocolate Chip Lactation Cookies",
                                       image: "https://firebasestorage.googleapis.com/v0/b/test-4c60c.appspot.com/o/cookie1%402x.png?alt=media&token=dadc7377-1b3b-439a-9948-8237ec944d07",
                                       content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                       isNewProduct: true,
                                       price: 18.569)

        return mockItems
    }
}
