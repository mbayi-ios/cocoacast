//
//  EpisodesView.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 17/10/2021.
//

import SwiftUI

struct EpisodesView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: EpisodesViewModel

    // MARK: - View

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isFetching {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    List(viewModel.episodeRowViewModels) { viewModel in
                        NavigationLink {
                            EpisodeView(
                                viewModel: EpisodeViewModel(
                                    episode: viewModel.episode
                                )
                            )
                        } label: {
                            EpisodeRowView(viewModel: viewModel)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("What's New")
        }
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView(viewModel: EpisodesViewModel())
    }
}
