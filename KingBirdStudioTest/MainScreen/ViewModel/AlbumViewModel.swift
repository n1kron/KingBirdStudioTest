//
//  AlbumViewModel.swift
//  KingBirdStudioTest
//
//  Created by  Kostantin Zarubin on 11.10.2019.
//  Copyright © 2019 com.incvattica. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AlbumViewModel {
    public let albums : PublishSubject<[Album]> = PublishSubject()
    private let disposable = DisposeBag()
        
    public func requestData() {
        
        APIManager.requestData(completion: { [weak self] (result) in
            let albums = result["photos"].arrayValue.compactMap { json in
                return Album(json: json)
            }
            CoreDataStuff.shared.saveData(albums)
            self?.albums.onNext(albums)
        }) { (error) in
            let savedArray = CoreDataStuff.shared.fetchData()
            self.albums.onNext(savedArray)
        }
    }
}
