import Foundation
@testable import ASCommerceProject

class MockNetwork: APIRequest {
    var mockData: Decodable?
    var error: APIError?
    let completion: (() -> Void)?

    init(responseData: Decodable, completion: (() -> Void)? = nil) {
        mockData = responseData
        error = nil
        self.completion = completion
    }

    init(error: APIError, completion: (() -> Void)? = nil) {
        mockData = nil
        self.error = error
        self.completion = completion
    }

    override func request<T>(router: APIRouter, completion: @escaping (Response<T, APIError>) -> Void) where T : Decodable {

        if let data = mockData as? T {
            completion(.success(data))
        }

        if let error = self.error {
            completion(.failure(error))
        }
    }

    enum MockError: Error {
        case dataNotFound
    }
}
