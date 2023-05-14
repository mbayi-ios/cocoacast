import Combine
import Foundation

final class EpisodesViewModel: ObservableObject {

    // MARK: - Properties

    @Published private(set) var episodes: [Episode] = []

    @Published private(set) var isFetching = false

    // MARK: -

    var episodeRowViewModels: [EpisodeRowViewModel] {
        episodes.map { EpisodeRowViewModel(episode: $0) }
    }

    // MARK: -

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initialization

    init() {
        fetchEpisodes()
    }

    // MARK: - Helper Methods

    private func fetchEpisodes() {
      var request = URLRequest(url: URL(string: "https://cocoacasts-mock-api.herokuapp.com/api/v1/episodes")!)

        request.addValue("1772bb7bc78941e2b51c9c67d17ee76e", forHTTPHeaderField: "X-API-TOKEN")

        isFetching = true

        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isFetching = false

                if error != nil || (response as? HTTPURLResponse)?.statusCode != 200 {
                    print("unable to fetch episodes")
                } else if let data = data, let episodes = try? JSONDecoder().decode([Episode].self, from: data){
                    self?.episodes = episodes
                }
            }
        }
        .resume()
    }

}
