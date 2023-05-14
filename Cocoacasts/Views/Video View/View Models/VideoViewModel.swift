import Combine
import Foundation
import AVFoundation

final class VideoViewModel: ObservableObject {

    // MARK: - Properties

    @Published private(set) var player: AVPlayer?

    // MARK: -

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(videoID: String) {
        fetchVideo(with: videoID)
    }

    // MARK: - Helper Methods

    private func fetchVideo(with videoID: String) {

    }

}
