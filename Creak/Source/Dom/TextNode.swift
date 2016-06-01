//
//  TextNode.swift
//  Creak
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public class TextNode: AbstractNode {
    
    var _text: String!
    
    var convertedText: String?
    
    init(text: String) {
        // remove double spaces
        super.init()
        var newText = stringReplace("\\s+", replacement: " ", subject: text)
        newText = stringReplace("&#10;", replacement: "\n", subject: newText)
        
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
