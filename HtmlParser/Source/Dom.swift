//
//  Dom.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public class Dom {
    
    var raw: String!
    
    var root: HtmlNode!
    
    private func parse() {
        root = HtmlNode(tag: "root")
    }
    
    public func loadStr(str: String) -> Dom {
        raw = str
        parse()
        return self
    }
    
    public func find(selector: String, nth: Int = 0) -> AbstractNode? {
        return root.find(selector, nth: nth)
    }
    
    public func findAll(selector: String) -> Array<AbstractNode> {
        return root.findAll(selector)
    }
    
}
