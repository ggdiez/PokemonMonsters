//
//  DateExtension.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
}
