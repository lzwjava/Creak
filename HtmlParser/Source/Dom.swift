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
    
    var content: Content!
    
    private func trim(s: String) -> String {
        return s.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    private func parse() {
        root = HtmlNode(tag: "root")
        var activeNode: HtmlNode? = root
        while activeNode != nil {
            let str = content.copyUntil("<")
            if (str == "") {
                var info = parseTag()
                if (!(info["status"] as! Bool)) {
                    activeNode = nil
                    continue
                }
                
                if (info["closing"] as! Bool) {
                    
                }
                
                let node = info["node"] as! HtmlNode
                activeNode!.addChild(node)
                if !node.tag.selfClosing {
                    activeNode = node
                }
            } else if (trim(str) != "") {
                let textNode = TextNode(text: str)
                activeNode?.addChild(textNode)
            }
        }
    }
    
    private func parseTag() -> Dictionary<String, AnyObject> {
        return [:]
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
