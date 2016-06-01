//
//  Collection.swift
//  Creak
//
//  Created by lzw on 5/14/16.
//  Copyright © 2016 lzwjava. All rights reserved.
//

import Foundation

public struct NodeGenerator: GeneratorType {
    
    public typealias Element = (Int, AbstractNode)
    
    public var arrayGenerate: IndexingGenerator<[AbstractNode]>?
    
    private var arrayIndex: Int = 0
    
    init(_ nodeCollection: NodeCollection) {
        self.arrayGenerate = nodeCollection.collection.generate()
    }
    
    public mutating func next() -> NodeGenerator.Element? {
        if let o = self.arrayGenerate?.next() {
            let i = self.arrayIndex
            self.arrayIndex += 1
            return (i, o)
        } else {
            return nil
        }
    }
}

public struct NodeIndex: ForwardIndexType, _Incrementable, Equatable, Comparable {
    
    let arrayIndex: Int?
    
    init() {
        self.arrayIndex = nil
    }
    
    init(arrayIndex: Int) {
        self.arrayIndex = arrayIndex;
    }
    
    public func successor() -> NodeIndex {
        return NodeIndex(arrayIndex: self.arrayIndex!.successor())
    }
}

public func ==(lhs: NodeIndex, rhs:NodeIndex) -> Bool {
    return lhs.arrayIndex == rhs.arrayIndex
}

public func <(lhs: NodeIndex, rhs:NodeIndex) -> Bool {
    return lhs.arrayIndex < rhs.arrayIndex
}

public func <=(lhs: NodeIndex, rhs:NodeIndex) -> Bool {
    return lhs.arrayIndex <= rhs.arrayIndex
}

public func >=(lhs: NodeIndex, rhs:NodeIndex) -> Bool {
    return lhs.arrayIndex >= rhs.arrayIndex
}

public func >(lhs: NodeIndex, rhs:NodeIndex) -> Bool {
    return lhs.arrayIndex > rhs.arrayIndex
}

public class NodeCollection: Swift.CollectionType, Swift.SequenceType, Swift.Indexable {
    
    var collection: [AbstractNode] = []
    
    public typealias Generator = NodeGenerator
    public typealias Index = NodeIndex
    
    public var startIndex: NodeCollection.Index {
        return NodeIndex(arrayIndex: self.collection.startIndex)
    }
    
    public var endIndex: NodeCollection.Index {
        return NodeIndex(arrayIndex: self.collection.endIndex)
    }
    
    public subscript (position: NodeCollection.Index) -> NodeCollection.Generator.Element {
        return (position.arrayIndex!, self.collection[position.arrayIndex!])
    }
    
    public var isEmpty: Bool {
        return self.collection.isEmpty
    }
    
    public var count: Int {
        return self.collection.count
    }
    
    public func underestimateCount() -> Int {
        return self.collection.underestimateCount()
    }
    
    public func generate() -> NodeCollection.Generator {
        return NodeCollection.Generator(self)
    }
}