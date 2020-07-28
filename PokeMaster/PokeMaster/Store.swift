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