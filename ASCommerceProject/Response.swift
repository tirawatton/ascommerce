import Foundation

enum Response<T, U> where U: Error {
    case success(T)
    case failure(U)
}
