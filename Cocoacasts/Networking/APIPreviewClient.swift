import Combine
import Foundation


struct APIPreviewClient: APIService {

    func signIn(email: String, password: String) -> AnyPublisher<SignInResponse, APIError> {
        Just(SignInResponse(accessToken: "123", refreshToken: "456"))
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func episodes() -> AnyPublisher<[Episode], APIError> {
        return Just(stubData(for: "episodes"))
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func video(id: String, accessToken: String) -> AnyPublisher<Video, APIError> {
        Just(stubData(for: "video"))
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}


fileprivate extension  APIPreviewClient {
    func stubData<T: Decodable>(for resource: String)-> T {
        guard
            let url = Bundle.main.url(forResource: resource, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let stubData = try? JSONDecoder().decode(T.self, from: data)
        else {
            fatalError("unable to load stub data")
        }
        return stubData
    }
}
