import Foundation

enum APIError: LocalizedError {
    case unknownError
    case networkError(status: Int, description: String)
    case dataError(description: String)

    var localizedDescription: String {
        switch self {
        case .unknownError:
            return "Unknown Error has Occurred"
        case let .networkError(status: status, description: desc):
            return "\(status): \(desc)"
        case let .dataError(description: desc):
            return desc
        }
    }

}
