import UIKit

final class ProductsCoordinator: Coordinator {

    private(set) var childCoordinator: [Coordinator] = []
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startViewController() {
        let productsViewController = ProductsViewController.instantiate(for: ProductsViewModel())
        navigationController.navigationBar.isTranslucent = false
        navigationController.setViewControllers([productsViewController], animated: false)
    }
}
