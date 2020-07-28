//
//  AppError.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/28.
//  Copyright © 2020 Harlans. All rights reserved.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }
    
    case passwordWrong
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
            case .passwordWrong: return "密码错误"
        }
    }
}