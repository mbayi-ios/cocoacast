import Combine
import Foundation
import AVFoundation

final class VideoViewModel: ObservableObject {

    @Published private(set) var player: AVPlayer?

    @Published private(set) var isFetching = false

    @Published private(set) var errorMessage: String?

    private let apiService: APIService


    private var subscriptions: Set<AnyCancellable> = []


    init(videoID: String, apiService: APIService) {
        self.apiService = apiService
        fetchVideo(with: videoID)
    }


    private func fetchVideo(with videoID: String) {
        isFetching = true
        apiService.video(id: videoID, accessToken: "abcdef")
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false

                switch completion {
                case .finished:
                    print("successfully fetched video")
                case .failure(let error):
                    print("unable to fetch video \(error)")
                }
            }, receiveValue: {[weak self] video in
                self?.player = AVPlayer(url: video.videoURL)
            }).store(in: &subscriptions)
    }

}
