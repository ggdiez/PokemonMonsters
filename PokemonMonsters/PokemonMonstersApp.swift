//
//  PokemonMonstersApp.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import SwiftUI

@main
struct PokemonMonstersApp: App {
    var body: some Scene {
        WindowGroup {
            let isRunningUnitTests = NSClassFromString("XCTest") != nil

            if isRunningUnitTests {
                AnyView(EmptyView())
            }else {
                AnyView(HomeConnector().assembleModule())
            }
        }
    }
}
