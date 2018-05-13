//
//  CoreDataLocalStorage.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreData

class CoreDataLocalStorage: LocalStorage {
  func save<M: DBMapper>(object: M.Domain, mapper: M) {
    mapper.map(domain: object)
    CoreDataStack.saveContext()
  }
  
  func queryOne<M: DBMapper>(withUsername username: String, mapper: M, completion: @escaping (M.Domain?, Error?) -> ()) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: mapper.entityName)
    request.fetchLimit = 1
    request.predicate = NSPredicate(format: "login == %@", username)
    do {
      guard
        let fetchedObjects = try CoreDataStack.managedObjectContext.fetch(request) as? [M.DBObject],
        let object = fetchedObjects.first,
        let domain = mapper.map(dbObject: object) else {
          completion(nil, nil)
          return
      }
      completion(domain, nil)
    } catch {
      completion(nil, error)
    }
  }
}
