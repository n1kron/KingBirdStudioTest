//
//  ApiManager.swift
//  KingBirdStudioTest
//
//  Created by  Kostantin Zarubin on 11.10.2019.
//  Copyright © 2019 com.incvattica. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class APIManager {
    
    static func requestData(completion: @escaping (JSON)->Void, failure: @escaping (Error)->Void) {
        if let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=WVi9IxRamKU9uDhkRrfyCZvT7cIwBSxHO58TP71P&page=1") {
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
                .responseJSON { response in

                    switch response.result {

                    case .success(let json):
                        print(json)
                        completion(JSON(json))
                    case .failure(let error):
                        print(error)
                        failure(error)
                    }
            }
        }
    }
}
