//
//  ImgurAPI.swift
//  iOSProof
//
//  Created by Adrian de Almeida on 06/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import Moya

enum ImgurAPI {
    case getImage(search: String)
}

extension ImgurAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.imgur.com") else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }

    var path: String {
        switch self {
        case .getImage:
            return "/3/gallery/search/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getImage:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getImage(let search):
            return .requestParameters(parameters: ["q": "\(search)"], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getImage:
            return ["Authorization": "Client-ID 1ceddedc03a5d71"]
        }
    }
}
