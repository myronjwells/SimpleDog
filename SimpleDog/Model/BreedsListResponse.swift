//
//  BreedsListResponse.swift
//  SimpleDog
//
//  Created by Myron Wells on 9/30/19.
//  Copyright © 2019 Myron Wells. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
