//
//  Store.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/27.
//  Copyright © 2020 Harlans. All rights reserved.
//

import Combine

class Store: ObservableObject {
    @Published var appState = AppState()
    
    private let bag = DisposeBag()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        appState.settings.checker.isEmailValid.sink { isValid in
            self.dispatch(.emailValid(valid: isValid))
        }.add(to: bag)
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand?
        
        switch action {
            case .login(let email, let password):
                guard !appState.settings.loginRequesting else {
                    break
                }
                appState.settings.loginRequesting = true
                appCommand = LoginAppCommand(email: email, password: password)
                if password == "password" {
                    let user = User(email: email, favoritePokemonIDs: [])
                    appState.settings.loginUser = user
            }
            case .accountBehaviorDone(let result):
                appState.settings.loginRequesting = false
                switch result {
                    case .success(let user):
                        appState.settings.loginUser = user
                    case .failure(let error):
                        appState.settings.loginError = error
            }
            case .emailValid(let valid):
                appState.settings.isEmailValid = valid
            case .loadPokemons:
                if appState.pokemonList.loadingPokemons {
                    break
                }
                appState.pokemonList.loadingPokemons = true
                appCommand = LoadPokemonsCommand()
            
            case .loadPokemonsDone(let result):
                switch result {
                    case .success(let models):
                        appState.pokemonList.pokemons = Dictionary(uniqueKeysWithValues: models.map { ($0.id, $0) })
                    case .failure(let error):
                    print(error)
            }
            case .toggleListSelection(let index):
                let expanding = appState.pokemonList.selectionState.expandingIndex
                if expanding == index {
                    appState.pokemonList.selectionState.expandingIndex = nil
                    appState.pokemonList.selectionState.panelPresented = false
                } else {
                    appState.pokemonList.selectionState.expandingIndex = index
                    appState.pokemonList.selectionState.panelIndex = index
                }

            case .togglePanelPresenting(let presenting):
                appState.pokemonList.selectionState.panelPresented = presenting
            
            case .closeSafariView:
                appState.pokemonList.isSFViewActive = false
            
            case .loadAbilities(let pokemon):
                appCommand = LoadAbilitiesCommand(pokemon: pokemon)
            case .loadAbilitiesDone(let result):
                switch result {
                case .success(let loadedAbilities):
                    var abilities = appState.pokemonList.abilities ?? [:]
                    for ability in loadedAbilities {
                        abilities[ability.id] = ability
                    }
                    appState.pokemonList.abilities = abilities
                case .failure(let error):
                    print(error)
                }
            case .toggleFavorite(let index):
                guard let loginUser = appState.settings.loginUser else {
                    appState.pokemonList.favoriteError = .requiresLogin
                    break
                }

                var newFavorites = loginUser.favoritePokemonIDs
                if newFavorites.contains(index) {
                    newFavorites.remove(index)
                } else {
                    newFavorites.insert(index)
                }
                appState.settings.loginUser!.favoritePokemonIDs = newFavorites
            case .switchTab(let index):
            appState.pokemonList.selectionState.panelPresented = false
            appState.mainTab.selection = index
        }
        return (appState, appCommand)
    }
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION]:\(action)")
        #endif
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            #if DEBUG
            print("[COMMAND]:\(command)")
            #endif
            command.execute(in: self)
        }
    }
}


class DisposeBag {
    private var values: [AnyCancellable] = []
    
    func add(_ value: AnyCancellable) {
        values.append(value)
    }
}

extension AnyCancellable {
    func add(to bag: DisposeBag) {
        bag.add(self)
    }
}
