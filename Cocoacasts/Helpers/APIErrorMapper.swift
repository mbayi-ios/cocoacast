import Foundation

struct APIErrorMapper {

    enum Context {
        case signIn
        case episodes
    }

    let error: APIError
    let context: Context

    var message: String {
        switch error {
        case .unreachable:
            return "You need network connection"

        case .unknown,
             .failedRequest,
             .invalidResponse:
            switch context {
            case .signIn:
                return "the email and password combination is invalid"
                
            case .episodes:
                return "the list of episodes could not be returned"
            }

        }
    }
}
