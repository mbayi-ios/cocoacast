import Foundation

enum APIError: Error {
    case unknown
    case unreachable
    case failedRequest
    case invalidResponse

    var message: String {
        switch self {
        case .unreachable:
            return "You need to have a network connection"
        case .unknown,
                .failedRequest,
                .invalidResponse:
            return "the list of episodes could not be fetched"
        }
    }
}
