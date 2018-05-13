//
//  LocalStorage.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

protocol LocalStorage {
  func save<T: DBObject>(object: T)
}
