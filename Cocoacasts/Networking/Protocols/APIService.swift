import Foundation
import Combine

protocol APIService {
    func episodes() -> AnyPublisher<[Episode], APIError>

    func signIn(email: String, password: String) -> AnyPublisher<SignInResponse, APIError>
}
