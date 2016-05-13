//
//  Tag.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public class Tag {
    
    var encode: UInt = NSUTF8StringEncoding
    
    var name: String = ""
    
    init(name: String) {
        self.name = name
    }
    
    public func attributes() -> Dictionary<String, String?> {
        return [:]
    }
    
    public func attribute(key: String) -> String? {
        return nil
    }
    
    public func setAttribute(key: String, value: AnyObject) {
        
    }
    
    public func removeAttribute(key: String) {
        
    }
    
    public func removeAllAttributes() {
        
    }
}