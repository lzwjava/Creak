//
//  AbstractNode.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public struct AbstractNode {
    
    var tag: String = ""
    
    var attr: Array<String> = []
    
    var parent: AbstractNode?
    
    var id: String = ""
    
    var encode: String = ""
    
    public init() {
        self.id = NSUUID().UUIDString
    }
    
}