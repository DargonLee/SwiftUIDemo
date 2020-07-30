//
//  AppCommand.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/28.
//  Copyright © 2020 Harlans. All rights reserved.
//

import Foundation
import Combine

protocol AppCommand {
    func execute(in store: Store)
}


struct LoginAppCommand: AppCommand {
    let email: String
    let password: String
    
    func execute(in store: Store) {
        _ = LoginRequest(email: email, password: password)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
            }, receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            }
        )
    }
}

struct LoadPokemonsCommand: AppCommand {
    func execute(in store: Store) {
        _ = LoadPokemonRequest.all
            .sink(receiveCompletion: { complete in
            if case.failure(let error) = complete {
                store.dispatch(.loadPokemonsDone(result: .failure(error)))
            }
        }, receiveValue: { value in
            store.dispatch(.loadPokemonsDone(result: .success(value)))
        })
    }
}


struct LoadAbilitiesCommand: AppCommand {

    let pokemon: Pokemon

    func load(pokemonAbility: Pokemon.AbilityEntry, in store: Store)
        -> AnyPublisher<AbilityViewModel, AppError>
    {
        if let value = store.appState.pokemonList.abilities?[pokemonAbility.id.extractedID!] {
            return Just(value)
                .setFailureType(to: AppError.self)
                .eraseToAnyPublisher()
        } else {
            return LoadAbilityRequest(pokemonAbility: pokemonAbility).publisher
        }
    }

    func execute(in store: Store) {
        _ = pokemon.abilities
            .map { load(pokemonAbility: $0, in: store) }
            .zipAll
            .sink(
                receiveCompletion: { complete in
                    if case .failure(let error) = complete {
                        store.dispatch(.loadAbilitiesDone(result: .failure(error)))
                    }
                },
                receiveValue: { value in
                    store.dispatch(.loadAbilitiesDone(result: .success(value)))
                }
            )
    }
}

struct WriteUserAppCommand: AppCommand {
    let user: User
    
    func execute(in store: Store) {
        try?FileHelper.writeJSON(user, to: .documentDirectory, fileName: "user.json")
    }
}
