import Foundation
import Combine

final class APIClient: APIService {

    func signIn(email: String, password: String) -> AnyPublisher<SignInResponse, APIError> {
        request(.auth(email: email, password: password))
    }
    
    func episodes() -> AnyPublisher<[Episode], APIError> {
        request(.episodes)

    }

    private func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, APIError> {
        var request  = URLRequest(url: Environment.apiBaseURL.appendingPathComponent("episodes"))

        request.addValue(Environment.apiToken, forHTTPHeaderField: "X-API-TOKEN")

        return URLSession.shared
            .dataTaskPublisher(for: request )
            .tryMap{ data, response -> T in
                guard
                    let response = response as? HTTPURLResponse,
                    (200..<300).contains(response.statusCode)
                else {
                    throw APIError.failedRequest
                }
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    print("unable to decode response \(error)")
                    throw APIError.invalidResponse
                }
            }
            .mapError { error -> APIError in
                switch error  {
                case let apiError as APIError:
                    return apiError
                case URLError.notConnectedToInternet:
                    return APIError.unreachable
                default:
                    return APIError.failedRequest
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
