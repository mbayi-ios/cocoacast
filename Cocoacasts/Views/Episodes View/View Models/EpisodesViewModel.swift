import Combine
import Foundation

final class EpisodesViewModel: ObservableObject {

    private let apiService: APIService

    @Published private(set) var episodes: [Episode] = []

    @Published private(set) var isFetching = false

    @Published private(set) var errorMessage: String?



    var episodeRowViewModels: [EpisodeRowViewModel] {
        episodes.map { EpisodeRowViewModel(episode: $0) }
    }


    private var subscriptions: Set<AnyCancellable> = []



    init(apiService: APIService) {
        self.apiService = apiService
        fetchEpisodes()
    }



    private func fetchEpisodes() {

        isFetching = true

        apiService.episodes()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false

                switch completion {
                case .finished:
                    print("successfully fetched episodes")
                case .failure(let error):
                    print("unable to fetch episodes \(error)")
                    self?.errorMessage = APIErrorMapper(
                            error: error,
                            context: .episodes
                    ).message
                }
            }, receiveValue: { [ weak self] episodes in
                self?.episodes = episodes
            }).store(in: &subscriptions)
    }

}
