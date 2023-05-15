import AVKit
import SwiftUI

struct VideoView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: VideoViewModel

    // MARK: - View

    var body: some View {
        ZStack {
            Color.black
            if let player = viewModel.player {
                VideoPlayer(player: player)
            } else {
                ProgressView()
                    .tint(.white)
                    .progressViewStyle(.circular)
            }
        }
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }

}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(
            viewModel: VideoViewModel(
                videoID: Episode.episodes[0].videoID,
                apiService: APIPreviewClient()
            )
        )
    }
}
