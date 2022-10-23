//
//  PokemonCryView.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 29/8/22.
//

import SwiftUI
import CachedAsyncImage

struct PokemonCryView<ViewModel>: View, Equatable where ViewModel: PokemonCryViewModelProtocol {

    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel: ViewModel
    private let connector: PokemonCryViewConnector
    private let padding = 8.0
    private let longPadding = 20.0
    private let imageSize = 200.0
    private let playButtonTitle = "Tap me to Cry!!!"
    private let closeButtonTitle = "Close"


    // MARK: - Initializer
    init(viewModel: ViewModel, connector: PokemonCryViewConnector) {
        self.viewModel = viewModel
        self.connector = connector
    }

    static func == (lhs: PokemonCryView, rhs: PokemonCryView) -> Bool {
        return lhs.viewModel.getPokemonName() == rhs.viewModel.getPokemonName()
    }

    var body: some View {
        VStack {
            Button(closeButtonTitle) {
                closeView()
            }
            .padding(.leading, padding)
            .padding(.top, longPadding)
            .padding(.bottom, padding)

            Spacer()

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
            .padding(.bottom, padding)

            Button(playButtonTitle) {
                viewModel.playCry()
            }
            .padding(.leading, padding)
            .padding(.top, padding)

            Spacer()
        }
    }

    // MARK: - Auxiliar minimal funcs
    private func closeView() {
        self.viewModel.closeView()
        self.presentationMode.wrappedValue.dismiss()
    }
}
