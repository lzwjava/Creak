//
//  TextNode.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public class TextNode: LeafNode {
    
    var _text: String!
    
    var convertedText: String?
    
    private func stringReplace(pattern: String, replacement: String, subject: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        let resultText = regex.stringByReplacingMatchesInString(_text, options: .Anchored, range: NSMakeRange(0, _text.characters.count), withTemplate: replacement)
        return resultText
    }
    
    init(text: String) {
        // remove double spaces
        super.init()
        var newText = self.stringReplace("\\s+", replacement: " ", subject: text)
        newText = self.stringReplace("&#10;", replacement: "\n", subject: newText)
        
        self._text = newText
        self.tag = Tag(name: "text")
    }
    
    public override func text() -> String {
        if let encode = encode {
            if let convertedText = convertedText {
                return convertedText
            }
            // Todo, covert according to encoding
            convertedText = _text
            return convertedText!
        } else {
            return _text
        }
    }
    
    public override func innerHtml() -> String {
        return text()
    }
    
    public override func outerHtml() -> String {
        return text()
    }
    
    override func clear() {
        convertedText = nil
    }
    
}
