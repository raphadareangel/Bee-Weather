//
//  CoreDataManager.swift
//  testfinal2
//
//  Created by Rafael Torres Balderas on 19/02/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    ///store obj into core data check exist missing
    class func storeObj(id :String,
                        country:String,
                        name:String,
                        population:String) {
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "City", in: context)
        
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObj.setValue(id, forKey: "id")
        managedObj.setValue(country, forKey: "country")
        managedObj.setValue(name, forKey: "name")
        managedObj.setValue(population, forKey: "population")
       
        
        do {
            try context.save()
            print("city was saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    ///fetch all the objects from core data
    class func fetchObj() -> [cityItem]{
        var array = [cityItem]()
        
        let fetchRequest:NSFetchRequest<City> = City.fetchRequest()
        
       
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                let mItem = cityItem(id: item.id!,
                                     name : item.name!, country : item.country!,
                                        population : item.population!)
                    
                
                    array.append(mItem)

            }
        }catch {
            print(error.localizedDescription)
        }
        
        return array
    }
    
  
    
    
    ///delete data by id in core data
    class func deletecityCoreData(CityID : String) {
        
        let fetchRequest:NSFetchRequest<City> = City.fetchRequest()
        
        let predicate = NSPredicate(format: "id == %@" , CityID)
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting city")
            try getContext().execute(deleteRequest)
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    
}


