
import SwiftUI

struct RootView: View {

    private let keychainService = KeychainService()

    
    var body: some View {
        TabView {
            EpisodesView(viewModel: EpisodesViewModel(apiService: APIClient()))
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
