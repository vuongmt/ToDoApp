//
//  Item.swift
//  ToDoApp
//
//  Created by Minh Vuong on 1/16/18.
//  Copyright © 2018 Minh Vuong. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items") //creating inverse relationship from items to parent. "items" was created from the Category Class. 
    
}
