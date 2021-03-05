import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var productImageView: URLImage!
    @IBOutlet weak var newProductImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productContentLabel: UILabel!

    lazy var viewModel: ProductDetailViewModel = {
        return ProductDetailViewModel()
    }()

    var productId: Int?

    static func instantiate(for viewModel: ProductDetailViewModel, toSet productId: Int) -> ProductDetailViewController {
        let storyboard = UIStoryboard(name: .main, bundle: nil)
        let viewController = storyboard.instantiate(ProductDetailViewController.self)
        viewController.viewModel = viewModel
        viewController.productId = productId
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Products Detail"

        initViewModel()
    }

    private func initViewModel() {
        viewModel.reloadDataClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.setupProductDetail()
            }
        }
        
        viewModel.updateLoadingStatusClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                let isLoading = self.viewModel.isLoading
                self.setupSpinerLoader(set: isLoading)
            }
        }

        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                let message = self.viewModel.messageError
                self.displayAlert(message: message!)
            }
        }

        viewModel.fetchProductDetail(at: self.productId!)
    }

    func setupProductDetail() {
        guard let product = self.viewModel.product else { return }

        productImageView.downloadImage(with: product.image) { [weak self] image in
            self?.productImageView.image = image
        }

        self.productTitleLabel.text = product.title
        self.productPriceLabel.text = product.productsPrice
        self.productContentLabel.text = product.content

        if product.isNewProduct {
            self.newProductImageView.isHidden = false
        } else {
            self.newProductImageView.isHidden = true
        }
    }

    private func setupSpinerLoader(set isLoading: Bool) {
        if isLoading {
            self.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations: {
                self.scrollView.alpha = 0.0
            })
        } else {
            self.activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.2, animations: {
                self.scrollView.alpha = 1.0
                self.activityIndicator.alpha = 0
            })
        }
    }

    private func displayAlert(message: String) {
        let dialogMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)

        let ok = UIAlertAction(title: "Retry", style: .default, handler: { (action) -> Void in
            self.initViewModel()
        })

        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            self.createBlankViewController()
        }

        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)

        self.present(dialogMessage, animated: true, completion: nil)
    }

    private func createBlankViewController() {
        let viewController = FailedViewController.instantiate()
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.present(viewController, animated: true, completion: nil)
    }
}
