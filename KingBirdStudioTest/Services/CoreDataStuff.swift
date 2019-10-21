//
//  CoreDataStuff.swift
//  KingBirdStudioTest
//
//  Created by  Kostantin Zarubin on 21.10.2019.
//  Copyright © 2019 com.incvattica. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class CoreDataStuff {
    
    static let shared = CoreDataStuff()
    
    func saveData(_ albums: [Album]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        for album in albums {
            let newAlbum = NSEntityDescription.insertNewObject(forEntityName: "AlbumData", into: context)
            newAlbum.setValue(album.id, forKey: "id")
            newAlbum.setValue(album.img_src, forKey: "img_src")
        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func fetchData() -> [Album] {
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AlbumData")
        request.returnsObjectsAsFaults = false
        
        request.resultType = .dictionaryResultType
        do {
            let records = try context.fetch(request)
            var temp = [Album]()
            let json = JSON(records)
            
            for (_, object) in json {
                temp.append(Album(json: object))
            }
            
            return temp
        } catch {
            print("Error fetching data from CoreData")
            return []
        }
    }
}
