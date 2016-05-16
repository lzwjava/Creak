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
    
    var selfClosing = ["img", "br", "input", "meta", "link", "hr", "base", "embed", "spacer"]
    
    private func trim(s: String) -> String {
        return s.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    private func parse() {
        root = HtmlNode(tag: "root")
        var activeNode: HtmlNode? = root
        while activeNode != nil {
            let str = content.copyUntil("<")
            if (str == "") {
                let info = parseTag()
                if !info.status {
                    activeNode = nil
                    continue
                }
                
                if info.closing {
                    
                }
                
                if info.node == nil {
                    continue
                }
                
                let node = info.node!
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
    
    struct ParseInfo {
        var status = false
        var closing = false
        var node: HtmlNode?
        var tag: String?
    }
    
    private func parseTag() -> ParseInfo {
        var result = ParseInfo()
        if content.char() != ("<" as Character) {
            return result
        }
        
        if content.fastForward(1).char() == "/" {
            var tag = content.fastForward(1).copyByToken(Content.Token.Slash, char: true)
            content.copyUntil(">")
            content.fastForward(1)
            
            tag = tag.lowercaseString
            if selfClosing.contains(tag) {
                result.status = true
                return result
            } else {
                result.status = true
                result.closing = true
                result.tag = tag
                return result
            }
        }
        
        var tag = content.copyByToken(Content.Token.Slash, char: true).lowercaseString
        var node = HtmlNode(tag: tag)
        
        while content.char() != ">" &&
           content.char() != "/" {
            var space = content.skipByToken(Content.Token.Blank, copy: true)
            if space?.characters.count == 0 {
                content.fastForward(1)
                continue
            }
            
            var name = content.copyByToken(Content.Token.Equal, char: true)
            if name == "/" {
                break
            }
            
            
        }
        
        return result
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
