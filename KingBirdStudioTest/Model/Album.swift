//
//  Album.swift
//  KingBirdStudioTest
//
//  Created by  Kostantin Zarubin on 11.10.2019.
//  Copyright © 2019 com.incvattica. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Album: Codable {
    
    let id, img_src: String
    
    init(json: JSON) {
        self.img_src = json["img_src"].stringValue
        self.id = json["id"].stringValue
    }
}
