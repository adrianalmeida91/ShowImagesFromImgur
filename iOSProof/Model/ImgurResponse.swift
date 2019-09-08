//
//  ImgurResponse.swift
//  iOSProof
//
//  Created by Adrian de Almeida on 07/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation

struct ImgurResult: Decodable {
    let id: String?
    let title: String?
    let description: String?
    let tags: [TagResult]
}
