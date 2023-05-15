import SwiftUI

struct SignInView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: SignInViewModel

    // MARK: - View

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20.0) {
                    VStack(alignment: .leading, spacing: 20.0) {
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .fontWeight(.light)
                                .foregroundColor(.accentColor)
                        }
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Email")
                                .fontWeight(.light)
                            TextField("Email", text: $viewModel.email)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Password")
                                .fontWeight(.light)
                            SecureField("Password", text: $viewModel.password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                    }
                    CapsuleButton(title: "Sign In") {
                        viewModel.signIn()
                    }
                    .disabled(!viewModel.canSignIn)
                    Spacer()
                }
                .padding()
                .textFieldStyle(.roundedBorder)

                if viewModel.isSigningIn {
                    ZStack {
                        Color(white: 1.0)
                            .opacity(0.75)
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
            }
            .navigationTitle("Sign In")
        }
    }

}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(
            viewModel: SignInViewModel(
                apiService: APIPreviewClient(),
                keychainService: KeychainService()
            )
        )
    }
}
