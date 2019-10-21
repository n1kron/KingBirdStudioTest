//
//  AlbumsCollectionViewCell.swift
//  KingBirdStudioTest
//
//  Created by  Kostantin Zarubin on 11.10.2019.
//  Copyright © 2019 com.incvattica. All rights reserved.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {
    static let Identifier = "AlbumsCollectionViewCell"
    
    @IBOutlet weak var albumImage: UIImageView!
    
    override func prepareForReuse() {
        albumImage.image = UIImage()
    }
}
