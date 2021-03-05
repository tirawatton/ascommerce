import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var collectionViewAdapter: ProductsCollectionViewAdapter!

    lazy var viewModel: ProductsViewModel = {
        return ProductsViewModel()
    }()

    static func instantiate(for viewModel: ProductsViewModel) -> ProductsViewController {
        let storyboard = UIStoryboard(name: .main, bundle: nil)
        let viewController = storyboard.instantiate(ProductsViewController.self)
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Products"
        
        setupCollectionView()
        initViewModel()
    }

    private func setupCollectionView() {
        collectionViewAdapter = ProductsCollectionViewAdapter(delegate: self)
        collectionView.delegate = collectionViewAdapter
        collectionView.dataSource = collectionViewAdapter

        let nib = UINib(nibName: "ProductsCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: ProductsCollectionViewCell.identifier)

        let nibHeader = UINib(nibName: "ProductsHeaderCollectionReusableView", bundle: .main)
        collectionView.register(nibHeader, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProductsHeaderCollectionReusableView.identifier)
    }

    private func initViewModel() {
        viewModel.reloadCollectionViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
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

        viewModel.fetchProducts()
    }

    private func setupSpinerLoader(set isLoading: Bool) {
        if isLoading {
            self.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations: {
                self.collectionView.alpha = 0.0
            })
        } else {
            self.activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.2, animations: {
                self.collectionView.alpha = 1.0
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

extension ProductsViewController: ProductsCollectionViewProtocol {
    func itemSelected(at idexPath: IndexPath) {
        viewModel.product = viewModel.getProductsData(at: idexPath)
        guard let product = viewModel.product else { return }
        
        let viewController = ProductDetailViewController.instantiate(for: ProductDetailViewModel(), toSet: product.id)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func getProductData(at indexPath: IndexPath) -> ProductsModel {
        return viewModel.getProductsData(at: indexPath)
    }

    func retrieveNumberOfItems() -> Int {
        return viewModel.numberOfItems()
    }
}
