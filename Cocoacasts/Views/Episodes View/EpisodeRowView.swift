import SwiftUI

struct EpisodeRowView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: EpisodeRowViewModel

    // MARK: - View

    var body: some View {
        HStack(spacing: 8.0) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50.0)
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            VStack(alignment: .leading, spacing: 4.0) {
                Text(viewModel.title)
                    .font(.headline)
                    .fontWeight(.light)
                if let formattedVideoDuration = viewModel.formattedVideoDuration {
                    Text(formattedVideoDuration)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }

}

struct EpisodeRowView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeRowView(viewModel: EpisodeRowViewModel(episode: Episode.episodes[0]))
    }
}
