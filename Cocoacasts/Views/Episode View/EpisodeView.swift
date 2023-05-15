import SwiftUI

struct EpisodeView: View {

    // MARK: - Properties

    let viewModel: EpisodeViewModel

    // MARK: -

    @State private var showVideo = false

    // MARK: - View

    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100.0)
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            Text(viewModel.title)
                .font(.title)
                .fontWeight(.thin)

            CapsuleButton(title: "Play Episode") {
                showVideo.toggle()
            }
            .sheet(isPresented: $showVideo) {
                VideoView(
                    viewModel: VideoViewModel(
                        videoID: viewModel.videoID,
                        apiService: APIClient()
                    )
                )
            }

            Text(viewModel.excerpt)
                .padding()
            Spacer()
        }
    }

}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView(viewModel: EpisodeViewModel(episode: Episode.episodes[0]))
    }
}
