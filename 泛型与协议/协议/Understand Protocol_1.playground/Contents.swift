//: Playground - noun: a place where people can play

import UIKit

//理解 protocol

struct FiboIterator: IteratorProtocol {
    
    var state = (0,1)
    mutating func next() -> Int? {
        let nextValue = state.0
        state = (state.1, state.0 + state.1)
        return nextValue
    }
}


struct Fibo: Sequence{
    func makeIterator() -> FiboIterator {
        return FiboIterator();
    }
}

var fibo = Fibo()

var fiboIteator = fibo.makeIterator()

var i = 1

while let value = fiboIteator.next(), i != 10 {
    print(value)
    i += 1
}













