//
//  AppState.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/27.
//  Copyright © 2020 Harlans. All rights reserved.
//

import Foundation
import Combine

struct AppState {
    var settings = Settings()
    var pokemonList = PokemonList()
    var mainTab = MainTab()
}

extension AppState
{
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        
        enum AccountBehavior: CaseIterable {
            case register, login
        }
        
        class AccountChecker {
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            var isEmailValid: AnyPublisher<Bool, Never> {
                let remoteVerify = $email
                    .debounce(
                        for: .milliseconds(500),
                        scheduler: DispatchQueue.main
                    )
                    .removeDuplicates()
                    .flatMap { email -> AnyPublisher<Bool, Never> in
                        let validEmail = email.isValidEmailAddress
                        let canSkip = self.accountBehavior == .login
                        switch (validEmail, canSkip) {
                        case (false, _):
                            return Just(false).eraseToAnyPublisher()
                        case (true, false):
                            return EmailCheckingRequest(email: email)
                                .publisher
                                .eraseToAnyPublisher()
                        case (true, true):
                            return Just(true).eraseToAnyPublisher()
                        }
                    }

                let emailLocalValid = $email.map { $0.isValidEmailAddress }
                let canSkipRemoteVerify = $accountBehavior.map { $0 == .login }

                return Publishers.CombineLatest3(
                    emailLocalValid, canSkipRemoteVerify, remoteVerify
                )
                .map { $0 && ($1 || $2) }
                .eraseToAnyPublisher()
            }
        }
        var checker = AccountChecker()
        
        var isEmailValid: Bool = false
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
        var accountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        
        //@FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
        
//        var loginUser: User? = try? FileHelper.loadJSON(from: .documentDirectory, fileName: "user.json") {
//            didSet {
//                if let value = loginUser {
//                    try? FileHelper.writeJSON(value, to: .documentDirectory, fileName: "user.json")
//                }else {
//                    try? FileHelper.delete(from: .documentDirectory, fileName: "user.json")
//                }
//            }
//        }
        
        var loginRequesting = false
        
        var loginError: AppError?
        
    }
}


extension AppState {
    struct PokemonList {

        struct SelectionState {
            var expandingIndex: Int? = nil
            var panelIndex: Int? = nil
            var panelPresented = false
            var radarProgress: Double = 0
            var radarShouldAnimate = true

            func isExpanding(_ id: Int) -> Bool {
                expandingIndex == id
            }
        }

        @FileStorage(directory: .cachesDirectory, fileName: "pokemons.json")
        var pokemons: [Int: PokemonViewModel]?

        @FileStorage(directory: .cachesDirectory, fileName: "abilities.json")
        var abilities: [Int: AbilityViewModel]?

        func abilityViewModels(for pokemon: Pokemon) -> [AbilityViewModel]? {
            guard let abilities = abilities else { return nil }
            return pokemon.abilities.compactMap { abilities[$0.ability.url.extractedID!] }
        }

        var loadingPokemons = false
        var pokemonsLoadingError: AppError?

        var selectionState = SelectionState()
        var favoriteError: AppError?

        var searchText = ""

        var isSFViewActive = false

        func displayPokemons(with settings: Settings) -> [PokemonViewModel] {

            func isFavorite(_ pokemon: PokemonViewModel) -> Bool {
                guard let user = settings.loginUser else { return false }
                return user.isFavoritePokemon(id: pokemon.id)
            }

            func containsSearchText(_ pokemon: PokemonViewModel) -> Bool {
                guard !searchText.isEmpty else {
                    return true
                }
                return pokemon.name.contains(searchText) ||
                       pokemon.nameEN.lowercased().contains(searchText.lowercased())
            }

            guard let pokemons = pokemons else {
                return []
            }

            let sortFunc: (PokemonViewModel, PokemonViewModel) -> Bool
            switch settings.sorting {
            case .id:
                sortFunc = { $0.id < $1.id }
            case .name:
                sortFunc = { $0.nameEN < $1.nameEN }
            case .color:
                sortFunc = {
                    $0.species.color.name.rawValue < $1.species.color.name.rawValue
                }
            case .favorite:
                sortFunc = { p1, p2 in
                    switch (isFavorite(p1), isFavorite(p2)) {
                    case (true, true): return p1.id < p2.id
                    case (false, false): return p1.id < p2.id
                    case (true, false): return true
                    case (false, true): return false
                    }
                }
            }

            var filterFuncs: [(PokemonViewModel) -> Bool] = []
            filterFuncs.append(containsSearchText)
            if settings.showFavoriteOnly {
                filterFuncs.append(isFavorite)
            }

            let filterFunc = filterFuncs.reduce({ _ in true}) { r, next in
                return { pokemon in
                    r(pokemon) && next(pokemon)
                }
            }

            return pokemons.values
                .filter(filterFunc)
                .sorted(by: sortFunc)
        }
    }
}


extension AppState {
    struct MainTab {
        enum Index: Hashable {
            case list, settings
        }

        var selection: Index = .list
    }
}

struct User: Codable {
    var email: String
    
    var favoritePokemonIDs: Set<Int>
    
    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
}
