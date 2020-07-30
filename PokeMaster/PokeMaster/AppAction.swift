//
//  AppAction.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/28.
//  Copyright © 2020 Harlans. All rights reserved.
//

import Foundation

enum AppAction {
    case login(email: String, password: String)
    case accountBehaviorDone(result: Result<User, AppError>)
    case emailValid(valid: Bool)
    
    case loadPokemons
    case loadPokemonsDone(result: Result<[PokemonViewModel], AppError>)
    
    case toggleListSelection(index: Int?)
    case togglePanelPresenting(presenting: Bool)
    
    case closeSafariView
    
    case loadAbilities(pokemon: Pokemon)
    case loadAbilitiesDone(result: Result<[AbilityViewModel], AppError>)
    
    case toggleFavorite(index: Int)

    case switchTab(index: AppState.MainTab.Index)
}

