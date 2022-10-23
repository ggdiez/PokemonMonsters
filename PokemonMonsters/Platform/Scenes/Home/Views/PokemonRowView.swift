//
//  PokemonRowView.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import SwiftUI
import CachedAsyncImage

struct PokemonRowView<ViewModel>: View, Equatable where ViewModel: PokemonRowViewModelProtocol {

    // MARK: - Properties
    @ObservedObject private var viewModel: ViewModel
    private let connector: PokemonRowViewConnector
    private let padding = 8.0
    private let imageSize = 100.0


    // MARK: - Initializer
    init(viewModel: ViewModel, connector: PokemonRowViewConnector) {
        self.viewModel = viewModel
        self.connector = connector
    }

    var body: some View {
        HStack {
            if viewModel.pokemonItemDetail.imageURLPath != "", let url = URL(string: viewModel.pokemonItemDetail.imageURLPath) {
                CachedAsyncImage(url: url) { image in
                    image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: imageSize, maxHeight: imageSize)
                } placeholder: {
                    ProgressView()
                }
            } else {
                ProgressView()
            }

            Text(viewModel.pokemonItemDetail.name)
            .font(.title2)
            .padding(.leading, padding)
        }
    }

    static func == (lhs: PokemonRowView, rhs: PokemonRowView) -> Bool {
        return lhs.viewModel.getPokemonName() == rhs.viewModel.getPokemonName()
    }
}
