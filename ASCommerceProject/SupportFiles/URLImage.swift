import UIKit
import Kingfisher

public class URLImage: UIImageView {
    func downloadImage(with urlString : String , imageCompletionHandler: @escaping (UIImage?) -> Void){
        guard let url = URL.init(string: urlString) else {
            return  imageCompletionHandler(nil)
        }
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                self.addShadow(shadowSize: 3, shadowDistance: 5, color: .black, radius: 4, opacity: 0.2)
                imageCompletionHandler(value.image)
            case .failure:
                imageCompletionHandler(UIImage(named: "image_placeholder"))
            }
        }
    }
}
