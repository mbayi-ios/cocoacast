import Combine
import Foundation

final class EpisodesViewModel: ObservableObject {

    // MARK: - Properties

    @Published private(set) var episodes: [Episode] = []

    @Published private(set) var isFetching = false

    @Published private(set) var errorMessage: String?

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
            .tryMap { data, response -> [Episode] in
                guard
                    let response = response as? HTTPURLResponse,
                    (200..<300).contains(response.statusCode)
                else {
                    throw APIError.failedRequest
                }
                do {
                    return try JSONDecoder().decode([Episode].self, from: data)
                } catch{
                    print("unable to decode response \(error)")
                    throw APIError.invalidResponse
                }
            }
            .mapError { error -> APIError in
                switch error {
                case let apiError as APIError:
                    return apiError
                case URLError.notConnectedToInternet:
                    return APIError.unreachable
                default:
                    return APIError.failedRequest
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false

                switch completion {
                case .finished:
                    print("successfully fetched episodes")
                case .failure(let error):
                    print("unable to fetch episodes \(error)")
                    self?.errorMessage = error.message
                }
            }, receiveValue: { [ weak self] episodes in
                self?.episodes = episodes
            }).store(in: &subscriptions)
    }

}
