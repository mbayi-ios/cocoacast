import Combine
import Foundation


struct APIPreviewClient: APIService {

    func signIn(email: String, password: String) -> AnyPublisher<SignInResponse, APIError> {
        Just(SignInResponse(accessToken: "123", refreshToken: "456"))
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func episodes() -> AnyPublisher<[Episode], APIError> {
        guard
            let url = Bundle.main.url(forResource: "episodes", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let episodes = try? JSONDecoder().decode([Episode].self, from: data)
        else {
            fatalError("unable to load episodes")
        }

        return Just(episodes)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
