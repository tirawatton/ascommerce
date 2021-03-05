import UIKit

class FailedViewController: UIViewController {

    static func instantiate() -> FailedViewController {
        let storyboard = UIStoryboard(name: .main, bundle: nil)
        let viewController = storyboard.instantiate(FailedViewController.self)
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func retryAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
