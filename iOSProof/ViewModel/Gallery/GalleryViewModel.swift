//
//  GalleryViewModel.swift
//  iOSProof
//
//  Created by Adrian de Almeida on 06/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GalleryViewModel {

    private let disposeBag = DisposeBag()
    private var networkService: NetworkService
    private var imgurResultRelay = BehaviorRelay<[ImgurResult]>(value: [])
    var imgurResult: Driver<[ImgurResult]> {
        return imgurResultRelay.asDriver()
    }

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func getImages(search: String) {
        networkService.searchImages(search: search).subscribe({ (response) in
            switch response {
            case .success(let images):
                self.imgurResultRelay.accept(images.data)
            case .error(let error):
                print("\(error)")
                self.imgurResultRelay.accept([])
            }
        }).disposed(by: disposeBag)
    }
}
