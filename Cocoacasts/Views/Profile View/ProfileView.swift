import SwiftUI

struct ProfileView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: ProfileViewModel

    // MARK: - View

    var body: some View {
        VStack {
            if viewModel.isSignedIn {
                VStack(spacing: 20.0) {
                    Text("You are signed in.")
                    CapsuleButton(title: "Sign Out") {
                        viewModel.signOut()
                    }
                }
            } else {
                SignInView(
                    viewModel: SignInViewModel(
                        keychainService: viewModel.keychainService
                    )
                )
            }
        }
    }

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            viewModel: ProfileViewModel(
                keychainService: KeychainService()
            )
        )
    }
}
