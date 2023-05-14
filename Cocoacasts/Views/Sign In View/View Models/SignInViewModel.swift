import Combine
import Foundation

final class SignInViewModel: ObservableObject {

    // MARK: - Properties

    @Published var email = ""
    @Published var password = ""

    @Published private(set) var isSigningIn = false

    var canSignIn: Bool {
        email.isEmail && !password.isEmpty
    }

    // MARK: -

    private let keychainService: KeychainService

    // MARK: -

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }

    // MARK: - Public API

    func signIn() {

    }

}
