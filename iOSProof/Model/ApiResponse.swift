//
//  ApiResponse.swift
//  iOSProof
//
//  Created by Adrian de Almeida on 07/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    var success: Bool
    var status: Int
    var data: [T]
}
