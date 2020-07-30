//
//  EmailCheckingRequest.swift
//  PokeMaster
//
//  Created by Harlans on 2020/7/29.
//  Copyright © 2020 Harlans. All rights reserved.
//

import Foundation
import Combine

struct EmailCheckingRequest {
    let email: String

    var publisher: AnyPublisher<Bool, Never> {
        Future<Bool, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if self.email.lowercased() == "123@qq.com" {
                    promise(.success(false))
                } else {
                    promise(.success(true))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
