//
//  NetworkService.swift
//  iOSProof
//
//  Created by Adrian de Almeida on 06/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class NetworkService {
    private let decoder = JSONDecoder()
    private let imgurProvider: MoyaProvider<ImgurAPI>

    init() {
        let imgurProviderStubClosure = MoyaProvider<ImgurAPI>.neverStub
        imgurProvider = MoyaProvider<ImgurAPI>(stubClosure: imgurProviderStubClosure, plugins: [NetworkLoggerPlugin(verbose: true)])
    }

    func searchImages(search: String) -> Single<ApiResponse<ImgurResult>>{
        return imgurProvider.rx.request(.getImage(search: search)).map(ApiResponse<ImgurResult>.self, using: self.decoder)
    }
}
