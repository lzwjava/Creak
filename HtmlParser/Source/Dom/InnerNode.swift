//
//  InnerNode.swift
//  HtmlParser
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public class InnerNode: ArrayNode {
    
    public func removeChild(id: String) {
        
    }
    
    public func addChild(child: AbstractNode) {
        
    }
    
    public func nextChild(id: String) -> AbstractNode {
        return AbstractNode()
    }
    
    public func previousChild(id: String) -> AbstractNode {
        return AbstractNode()
    }
    
}