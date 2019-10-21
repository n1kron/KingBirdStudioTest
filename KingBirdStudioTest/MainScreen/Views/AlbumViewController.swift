//
//  ViewController.swift
//  KingBirdStudioTest
//
//  Created by  Kostantin Zarubin on 11.10.2019.
//  Copyright © 2019 com.incvattica. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class AlbumViewController: UIViewController {
    @IBOutlet private weak var albumsCollectionView: UICollectionView!
    
    public var albums = PublishSubject<[Album]>()
    private let disposeBag = DisposeBag()
    var homeViewModel = AlbumViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Curiosity"
        homeViewModel
               .albums
               .observeOn(MainScheduler.instance)
               .bind(to: albums)
               .disposed(by: disposeBag)
        
        self.setupBinding()
        albumsCollectionView.contentInset = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)

        homeViewModel.requestData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detailVC = segue.destination as! DetailViewController
            if let test = sender as? Event<Album> {
                detailVC.album = test.element
            }
        }
    }
    
    private func setupBinding() {
        
        albums.bind(to: albumsCollectionView.rx.items(cellIdentifier: AlbumsCollectionViewCell.Identifier, cellType: AlbumsCollectionViewCell.self)) {  (row,album,cell) in
            cell.albumImage.kf.setImage(with: URL(string: album.img_src))
        }.disposed(by: disposeBag)
        
        albumsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        albumsCollectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                }, completion: nil)
            })).disposed(by: disposeBag)
        
        albumsCollectionView.rx
            .modelSelected(Album.self)
            .subscribe({ [weak self] album in
                DispatchQueue.main.async {
                    self?.performSegue(withIdentifier: "ShowDetail", sender: album)
                }
            }).disposed(by: disposeBag)
    }
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

