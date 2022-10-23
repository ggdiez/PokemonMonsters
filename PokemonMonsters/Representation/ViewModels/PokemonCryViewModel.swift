//
//  PokemonCryViewModel.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 29/8/22.
//

import Foundation
import AVFoundation

protocol PokemonCryViewModelProtocol: PokemonCryViewModelOutput, PokemonCryViewModelInput {}

protocol PokemonCryViewModelOutput: ObservableObject {
    var pokemonItemDetail: PokemonDetailItemViewModel { get set }
    func getPokemonDetail()
    func getPokemonName() -> String
    func playCry()
    func closeView()
}

protocol PokemonCryViewModelInput: ObservableObject {}

final class PokemonCryViewModel: PokemonCryViewModelProtocol {

    // MARK: - Properties
    private let pokemonUseCaseFactory: PokemonUseCaseFactory
    private let pokemon: PokemonItemViewModel
    private var pokemonUseCase: UseCase?
    @Published var pokemonItemDetail: PokemonDetailItemViewModel
    private var player: AVPlayer?
    private let baseURLPath = "https://pokemoncries.com/cries-old/"
    private let extensionAudioFile = ".mp3"

    // MARK: Init
    init(pokemon: PokemonItemViewModel, pokemonUseCaseFactory: PokemonUseCaseFactory) {
        self.pokemon = pokemon
        self.pokemonUseCaseFactory = pokemonUseCaseFactory
        self.pokemonItemDetail = PokemonDetailItemViewModel(id: 1, name: "loading...", imageURLPath: "")
        self.getPokemonDetail()
    }

    // MARK: Output functions

    @objc func getPokemonDetail() {
        executeGetPokemonDetailUseCase()
    }

    func getPokemonName() -> String {
        return pokemon.name
    }

    func playCry() {

        let urlPath = ("\(baseURLPath)\(pokemonItemDetail.id)\(extensionAudioFile)")

        guard let url = URL(string: urlPath) else {
            return
        }

        playSystemSound(url: url)
    }

    func closeView() {
        guard let player = player else { return }

        player.pause()
        player.replaceCurrentItem(with: nil)
    }

    // MARK: - play Sound
    private func playSystemSound(url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            let playerItem = AVPlayerItem(url: url)

            player = AVPlayer(playerItem: playerItem)

            guard let player = player else { return }

            player.play()
        } catch {
            print("No se pudo ejecutar el sonido: \(url)")
        }
    }

    // MARK: Private functions

    private func executeGetPokemonDetailUseCase () {

        if let url = URL(string: pokemon.url) {
            pokemonUseCase = pokemonUseCaseFactory.getPokemonDetail(url: url,handler: { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let pokemonDetail):
                    self.pokemonItemDetail = PokemonDetailItemViewModel(pokemon: pokemonDetail)
                case .failure(let error):
                    Log.error("Error getting pokemon from viewModel: \(error)")
                }
                self.pokemonUseCase = nil
            })
            pokemonUseCase?.execute()
        }
    }
}


