import Foundation
import Combine

protocol APIService {
    func episodes() -> AnyPublisher<[Episode], APIError>
}
