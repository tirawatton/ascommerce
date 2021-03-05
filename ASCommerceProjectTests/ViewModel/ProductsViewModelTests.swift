import XCTest
@testable import ASCommerceProject

class ProductsViewModelTests: XCTestCase {

    var viewModel: ProductsViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ProductsViewModel()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testCountOfIndexPathItemsOfProducts() {
        mockRequestProductsSuccess()
        let count = viewModel.numberOfItems()
        let expectation = 3

        XCTAssertEqual(count, expectation)
    }

    func testGetIndexPathItemOfProducts() {
        mockRequestProductsSuccess()
        let indexPath = IndexPath(item: 0, section: 0)
        let items = viewModel.getProductsData(at: indexPath)
        let titleExpectation = "Signature Chocolate Chip Lactation Cookies"
        let imageExpectation = "https://firebasestorage.googleapis.com/v0/b/test-4c60c.appspot.com/o/cookie1%402x.png?alt=media&token=dadc7377-1b3b-439a-9948-8237ec944d07"
        let priceExpectation = "18.569"

        XCTAssertEqual(items.title, titleExpectation)
        XCTAssertEqual(items.image, imageExpectation)
        XCTAssertTrue(items.isNewProduct)
        XCTAssertEqual(items.productsPrice, priceExpectation)
    }

    func testProductsGetsMessageErrorWhenServieIsFailed() {
        APIRequest.shared = MockNetwork(error: APIError.networkError(status: -99,
                                                                     description: "Call network fail."))
        let failureExpectation = expectation(description: "Call network fail.")

        viewModel.showAlertClosure = {
            let message = self.viewModel.messageError
            XCTAssertEqual(message, "ไม่สามารถแสดงข้อมูลได้ขณะนี้")
            failureExpectation.fulfill()
        }

        viewModel.fetchProducts()

        wait(for: [failureExpectation], timeout: 1)
    }

    private func mockRequestProductsSuccess() {
        let response = productsData()
        APIRequest.shared = MockNetwork(responseData: response)

        viewModel.fetchProducts()
    }

    private func productsData() -> [ProductsModel] {
        let mockItems = [
           ProductsModel(id: 1,
                         title: "Signature Chocolate Chip Lactation Cookies",
                         image: "https://firebasestorage.googleapis.com/v0/b/test-4c60c.appspot.com/o/cookie1%402x.png?alt=media&token=dadc7377-1b3b-439a-9948-8237ec944d07",
                         content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                         isNewProduct: true,
                         price: 18.569),
            ProductsModel(id: 2,
                          title: "Signature Chocolate Chip Lactation Cookies",
                          image: "https://firebasestorage.googleapis.com/v0/b/test-4c60c.appspot.com/o/cookie1%402x.png?alt=media&token=dadc7377-1b3b-439a-9948-8237ec944d07",
                          content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          isNewProduct: true,
                          price: 18.569),
            ProductsModel(id: 1,
                          title: "Signature Chocolate Chip Lactation Cookies",
                          image: "https://firebasestorage.googleapis.com",
                          content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          isNewProduct: false,
                          price: 17.563)
        ]

        return mockItems
    }
}
