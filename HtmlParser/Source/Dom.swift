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

    private func parse() {
        root = HtmlNode(tag: "root")
        var activeNode: InnerNode? = root
        while activeNode != nil {
            let str = content.copyUntil("<")
            if (str == "") {
                let info = parseTag()
                if !info.status {
                    activeNode = nil
                    continue
                }
                
                if info.closing {
                    let originalNode = activeNode
                    while activeNode?.tag.name != info.tag {
                        activeNode = activeNode?.parent
                        if activeNode == nil {
                            // we could not find opening tag
                            activeNode = originalNode
                            break
                        }
                    }
                    if activeNode != nil {
                        activeNode = activeNode?.parent
                    }
                    continue
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
        
        let tag = content.copyByToken(Content.Token.Slash, char: true).lowercaseString
        let node = HtmlNode(tag: tag)
        
        while content.char() != ">" &&
           content.char() != "/" {
            let space = content.skipByToken(Content.Token.Blank, copy: true)
            if space?.characters.count == 0 {
                content.fastForward(1)
                continue
            }
            
            let name = content.copyByToken(Content.Token.Equal, char: true)
            if name == "/" {
                break
            }
            
            if name == "" {
                content.fastForward(1)
                continue
            }
            
            content.skipByToken(Content.Token.Blank)
            if content.char() == "=" {
                content.fastForward(1).skipByToken(Content.Token.Blank)
                var attr = AttrValue()
                let quote: Character? = content.char()
                if quote != nil {
                    if quote == "\"" {
                        attr.doubleQuote = true
                    } else {
                        attr.doubleQuote = false
                    }
                    content.fastForward(1)
                    var string = content.copyUntil(String(quote), char: true, escape: true)
                    var moreString = ""
                    repeat {
                        moreString = content.copyUntilUnless(String(quote), unless: "=>")
                        string += moreString
                    } while moreString != ""
                    attr.value = string
                    content.fastForward(1)
                    node.setAttribute(name, attrValue: attr)
                } else {
                    attr.doubleQuote = true
                    attr.value = content.copyByToken(Content.Token.Attr, char: true)
                    node.setAttribute(name, attrValue: attr)
                }
            } else {
                node.tag.setAttribute(name, attrValue: AttrValue(nil, doubleQuote: true))
                if content.char() != ">" {
                    content.rewind(1)
                }
            }
        }
        
        content.skipByToken(Content.Token.Blank)
        if content.char() == "/" {
            node.tag.selfClosing = true
            content.fastForward(1)
        } else if selfClosing.contains(tag) {
            node.tag.selfClosing = true
        }
        
        content.fastForward(1)
        
        result.status = true
        result.node = node
        
        return result
    }
    
    public func loadStr(str: String) -> Dom {
        raw = str
        
        let html = clean(str)
        content = Content(content: html)
        parse()
        return self
    }
    
    func clean(str: String) -> String {
        return str
    }
    
    public func find(selector: String, nth: Int = 0) -> AbstractNode? {
        return root.find(selector, nth: nth)
    }
    
    public func findAll(selector: String) -> Array<AbstractNode> {
        return root.findAll(selector)
    }
    
}
