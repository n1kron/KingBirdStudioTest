//
//  DetailViewController.swift
//  KingBirdStudioTest
//
//  Created by  Kostantin Zarubin on 14.10.2019.
//  Copyright © 2019 com.incvattica. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: EEZoomableImageView! {
          didSet {
              imageView.minZoomScale = 0.5
              imageView.maxZoomScale = 5.0
              imageView.resetAnimationDuration = 0.5
          }
      }
    
    public var album: Album?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.kf.setImage(with: URL(string: album?.img_src ?? ""))
    }
}
