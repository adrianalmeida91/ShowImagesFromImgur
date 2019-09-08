//
//  ViewController.swift
//  iOSProof
//
//  Created by Adrian de Almeida on 06/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GalleryViewController: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!

    let searchExample = "cats"
    var viewModel: GalleryViewModel!

    private let disposeBag = DisposeBag()
    private var imgurResultList: [ImgurResult] = []
    private var images: [ImageResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSubscribe()
        callService()
    }

    func setupCollectionView() {
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(UINib(resource: R.nib.galleryCollectionViewCell), forCellWithReuseIdentifier: R.reuseIdentifier.galleryCollectionViewCell.identifier)
    }

    func setupSubscribe() {
        viewModel.imgurResult.drive(onNext: { (imgurResult) in
            self.imgurResultList = imgurResult
            self.images = []
            for imgurResult in self.imgurResultList {
                if let imagesResult = imgurResult.images {
                    let imagesFilters = imagesResult.filter({ (imageResult) -> Bool in
                        !(imageResult.link?.contains("mp4") ?? true)
                    })
                    self.images.append(contentsOf: imagesFilters)
                }
            }
            self.galleryCollectionView.reloadData()
        }).disposed(by: disposeBag)
    }

    func callService() {
        viewModel.getImages(search: searchExample)
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.galleryCollectionViewCell.identifier, for: indexPath) as! GalleryCollectionViewCell
        cell.loadImage(urlString: images[indexPath.item].link)
        return cell
    }
}
