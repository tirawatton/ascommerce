import XCTest
@testable import ASCommerceProject

class ProdoctDetailViewModelTests: XCTestCase {

    var viewModel: ProductDetailViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ProductDetailViewModel()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testGetProductDetailData() {
        mockRequestProductDetailSuccess(at: 1)
        
        let object = viewModel.product
        let titleExpectation = "Signature Chocolate Chip Lactation Cookies"
        let imageExpectation = "https://firebasestorage.googleapis.com/v0/b/test-4c60c.appspot.com/o/cookie1%402x.png?alt=media&token=dadc7377-1b3b-439a-9948-8237ec944d07"
        let priceExpectation = "18.569"

        guard let item = object else {
            return
        }

        XCTAssertEqual(item.title, titleExpectation)
        XCTAssertEqual(item.image, imageExpectation)
        XCTAssertTrue(item.isNewProduct)
        XCTAssertEqual(item.productsPrice, priceExpectation)
    }

    func testProductDetailGetsMessageErrorWhenServieIsFailed() {
        APIRequest.shared = MockNetwork(error: APIError.networkError(status: -99,
                                                                     description: "Call network fail."))
        let failureExpectation = expectation(description: "Call network fail.")

        viewModel.showAlertClosure = {
            let message = self.viewModel.messageError
            XCTAssertEqual(message, "ไม่สามารถแสดงข้อมูลได้ขณะนี้")
            failureExpectation.fulfill()
        }
        
        viewModel.fetchProductDetail(at: 1)

        wait(for: [failureExpectation], timeout: 1)
    }

    private func mockRequestProductDetailSuccess(at productId: Int) {
        let response = productData()
        APIRequest.shared = MockNetwork(responseData: response)

        viewModel.fetchProductDetail(at: productId)
    }

    private func productData() -> ProductsModel {
        let mockItem = ProductsModel(id: 1,
                                     title: "Signature Chocolate Chip Lactation Cookies",
                                     image: "https://firebasestorage.googleapis.com/v0/b/test-4c60c.appspot.com/o/cookie1%402x.png?alt=media&token=dadc7377-1b3b-439a-9948-8237ec944d07",
                                     content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                     isNewProduct: true,
                                     price: 18.569)
        return mockItem
    }
}
