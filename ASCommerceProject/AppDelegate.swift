import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UINavigationBar.appearance().barTintColor = UIColor(hex: "#E30909")
        UINavigationBar.appearance().tintColor = .white

        let attributes = [NSAttributedString.Key.font: UIFont(name: "Thonburi-Bold", size: 22)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = attributes
        return true
    }
}
