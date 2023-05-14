
import SwiftUI

struct RootView: View {

    // MARK: - Properties

    private let keychainService = KeychainService()

    // MARK: - View
    
    var body: some View {
        TabView {
            EpisodesView(viewModel: EpisodesViewModel())
                .tabItem {
                    Label("What's New", systemImage: "film")
                }
            ProfileView(viewModel: ProfileViewModel(keychainService: keychainService))
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }

}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
