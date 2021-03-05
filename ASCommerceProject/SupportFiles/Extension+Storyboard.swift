import UIKit

extension UIStoryboard {
    convenience init(name storyboard: StoryboardConstants, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }

    func instantiate<T: UIViewController>(_ type: T.Type, file: StaticString = #file, line: UInt = #line) -> T {
        let typeDescription = String(describing: type)
        guard let controller = instantiateViewController(withIdentifier: typeDescription) as? T else {
            fatalError("Couldn't instantiate \(typeDescription)", file: file, line: line)
        }

        return controller
    }
}

enum StoryboardConstants: String {
    case main = "Main"
}
