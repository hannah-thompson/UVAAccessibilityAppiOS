//
//  ResourceItem.swift
//  UVA Accessibility
//
//  Created by Hannah Marie Thompson on 11/23/18.
//  Copyright © 2018 Hannah Marie Thompson. All rights reserved.
//

import Foundation

class ResourceItem: Comparable{
    static func == (lhs: ResourceItem, rhs: ResourceItem) -> Bool {
        return (lhs.name == rhs.name)
    }
    
    
    var name: String = ""
    var titles: [String]
    var links: [String]
    
    
    init(name: String, titles:[String], links: [String]) {
        self.name = name
        self.titles = titles
        self.links = links
    }
    
    static func < (lhs: ResourceItem, rhs: ResourceItem) -> Bool {
        return (lhs.name < rhs.name)
    }
}
