import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
}

enum APIRouter: APIConfiguration {

    case products
    case product(productId: Int)

    // MARK: - HTTPMethod
    internal var method: HTTPMethod {
        switch self {
        case .products:
            return .get
        case .product:
            return .get
        }
    }

    // MARK: - Path
    internal var path: String {
        switch self {
        case .products:
            return "products"
        case .product(productId: let productId):
            return "products/\(productId)"
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.Dev.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
}
