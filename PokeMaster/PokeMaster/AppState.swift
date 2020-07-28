//
//  AppState.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/27.
//  Copyright © 2020 Harlans. All rights reserved.
//

import Foundation


struct AppState {
    var settings = Settings()
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
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
        var accountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
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

struct User: Codable {
    var email: String
    
    var favoritePokemonIDs: Set<Int>
    
    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
}
