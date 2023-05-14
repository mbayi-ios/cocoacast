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

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Episode].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false

                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    print("unable to fetch episodes \(error)")
                }
            }, receiveValue: { [ weak self] episodes in
                self?.episodes = episodes
            }).store(in: &subscriptions)
    }

}
