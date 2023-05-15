import Combine
import Foundation

final class SignInViewModel: ObservableObject {

    private let apiService: APIService

    @Published private(set) var errorMessage: String?

    @Published var email = ""
    @Published var password = ""

    @Published private(set) var isSigningIn = false

    var canSignIn: Bool {
        email.isEmail && !password.isEmpty
    }

    private let keychainService: KeychainService


    private var subscriptions: Set<AnyCancellable> = []


    init(apiService: APIService, keychainService: KeychainService) {
        self.apiService = apiService
        self.keychainService = keychainService
    }


    func signIn() {
        guard canSignIn else {
            return
        }

        isSigningIn = true
        errorMessage = nil

        apiService.signIn(email: email, password: password)
            .sink(receiveCompletion: { [weak self] completion in
                self?.password = ""
                self?.isSigningIn = false

                switch completion {
                case .finished:
                    ()
                case .failure:
                    self?.errorMessage = "The email/password combination is invalid"

                }
            }, receiveValue: {[ weak self] response in
                self?.keychainService.setAccessToken(response.accessToken)
                self?.keychainService.setRefreshToken(response.refreshToken)
            }).store(in: &subscriptions)
    }

}
