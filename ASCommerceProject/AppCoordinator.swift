import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get }
    func startViewController()
}

final class AppCoordinator: Coordinator {
    private(set) var childCoordinator: [Coordinator] = []

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func startViewController() {
        let navigationController = UINavigationController()
        let productsCoordinator = ProductsCoordinator(navigationController: navigationController)

        childCoordinator.append(productsCoordinator)

        productsCoordinator.startViewController()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
