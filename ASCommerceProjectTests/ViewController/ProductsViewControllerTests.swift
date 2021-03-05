import XCTest
@testable import ASCommerceProject

class ProductsViewControllerTests: XCTestCase {

    var viewController: ProductsViewController!

    override func setUp() {
        super.setUp()
        let viewController = ProductsViewController.instantiate(for: ProductsViewModel())
        _ = viewController.view

        self.viewController = viewController
    }

    override func tearDown() {
        super.tearDown()
        viewController = nil
    }

    func testCollectionView_whenFetchProductsIsSucceed_shouldNotBeNull() {
        mockRequestProductsSuccess()

        XCTAssertNotNil(viewController.collectionView)
    }

    func testCollectionView_whenFetchProductsIsSucceed_shouldHave2ItemsInSection0() {
        mockRequestProductsSuccess()

        let actual = viewController.collectionViewAdapter.collectionView(viewController.collectionView, numberOfItemsInSection: 0)

        XCTAssertEqual(actual, 3)
    }

    func testCollectionViewSetMinimumLineSpacingForSectionAt() {
        mockRequestProductsSuccess()

        let collectionView = viewController.collectionViewAdapter.collectionView(viewController.collectionView, layout: viewController.collectionView.collectionViewLayout, minimumLineSpacingForSectionAt: 0)
        XCTAssertEqual(collectionView, 16.0)
    }

    func testCollectionViewSetMinimumInteritemSpacingForSectionAt() {
        mockRequestProductsSuccess()

        let collectionView = viewController.collectionViewAdapter.collectionView(viewController.collectionView, layout: viewController.collectionView.collectionViewLayout, minimumInteritemSpacingForSectionAt: 0)
        XCTAssertEqual(collectionView, 0)
    }

    func testCollectionViewCalculateSizeForItemAt() {
        mockRequestProductsSuccess()

        let indexPath = IndexPath(row: 0, section: 0)

        let collectionView = viewController.collectionView
        let size = CGSize(width: ((collectionView?.frame.width)! / 2) - 24, height: ((collectionView?.frame.height)! / 3 ) - 28)
        let collectionViewSizeForItemAt = viewController.collectionViewAdapter.collectionView(viewController.collectionView, layout: viewController.collectionView.collectionViewLayout, sizeForItemAt: indexPath)

        XCTAssertEqual(collectionViewSizeForItemAt, size)
    }

    func testCollectionViewIsSetIndexDefaultsSelection() {
        mockRequestProductsSuccess()

        let indexPathSelected = IndexPath(row: 2, section: 0)
        viewController.collectionViewAdapter.collectionView(viewController.collectionView, didSelectItemAt: indexPathSelected)

        let idExpectation = 1
        XCTAssertEqual(viewController.viewModel.product?.id, idExpectation)
    }

    func testCollectionViewCell_shouldBeShownTheDataWithProductsCollectionViewCell() {
        mockRequestProductsSuccess()

        let indexPathCollectionView = IndexPath(item: 2, section: 0)

        let expectedCell = viewController.collectionViewAdapter.collectionView(viewController.collectionView, cellForItemAt: indexPathCollectionView) as! ProductsCollectionViewCell

        XCTAssertEqual(expectedCell.productTitleLabel.text, "Signature Chocolate Chip Lactation Cookies")
        XCTAssertEqual(expectedCell.productPriceLabel.text, "17.563")
    }

    private func mockRequestProductsSuccess() {
        let response = productsData()
        APIRequest.shared = MockNetwork(responseData: response)

        viewController.viewDidLoad()
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
