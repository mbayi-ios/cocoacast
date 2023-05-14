
import UIKit
import Combine
import Foundation

internal final class EpisodeRowViewModel: ObservableObject, Identifiable {

    // MARK: - Properties

    let episode: Episode

    // MARK: -

    var id: Int {
        episode.id
    }

    var title: String {
        episode.title
    }

    @Published private(set) var image: UIImage?

    // MARK: -

    private(set) lazy var formattedVideoDuration: String? = {
        VideoDurationFormatter().string(
            from: TimeInterval(episode.videoDuration)
        )
    }()

    // MARK: -

    private var cloudinaryURL: URL {
        CloudinaryURLBuilder(source: episode.imageURL)
            .width(50)
            .height(50)
            .build()
    }

    // MARK: - Initialization

    init(episode: Episode) {
        self.episode = episode

        fetchImage()
    }

    // MARK: - Helper Methods

    private func fetchImage() {
        URLSession.shared.dataTask(with: cloudinaryURL) { [weak self] data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }

}
