//
//  GalleryCollectionViewCell.swift
//  iOSProof
//
//  Created by Adrian de Almeida on 07/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit
import Kingfisher

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    func loadImage(urlString: String?) {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                imageView.kf.indicatorType = .activity
                imageView.kf.setImage(with: url, placeholder: UIImage(resource: R.image.image_not_found)) { result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
