//
//  Category.swift
//  ToDoApp
//
//  Created by Minh Vuong on 1/16/18.
//  Copyright © 2018 Minh Vuong. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
    
}
