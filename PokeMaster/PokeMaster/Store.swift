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
