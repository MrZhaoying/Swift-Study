//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//如果遇到要用多种算法表达的同样的操作，并且算法对它们的泛型参数又有不同的要求的代码的时候，就会用到带有泛型代码的重载

//例子: 有一个对于数组元素是否完全是另一个数组的子集
extension Sequence where Element : Equatable{
    
    func isSubset(to others : [Element]) -> Bool {
        for element in self {
            print("会走这里吗")
            guard others.contains(element) else {
                return false
            }
        }
        return true
    }
}

let set1 = [1,3,8,0,5,9]

let set2 = [0,1,2,3,4,5,6,7,8,9,10]

set1.isSubset(to: set2)

let arr1 = ["Swift", "Java", "OC", "JS", "Python"]

let arr2 = ["Java", "JS"]

arr2.isSubset(to: arr1)


extension Array{
    func binarySearch(for value : Element, areInIncreasingOrder:(Element, Element) -> Bool) -> Int? {
        //最小的索引
        var left = 0
        //最大的索引
        var right = count - 1
        
        while left <= right {
            //二分
            let mid = (left + right) / 2
            let candidate = self[mid]
            if areInIncreasingOrder(candidate,value) {
                left = mid + 1
            } else if areInIncreasingOrder(value,candidate) {
                right = mid - 1
            } else {
                // 由于 isOrderedBefore 的要求，如果两个元素互无顺序关系，那么它们一定相等
                return mid
            }
        }
        // 未找到
        return nil
    }
}

extension Array where Element : Comparable{
    func binartSearch(for value : Element) -> Int? {
        return self.binarySearch(for: value, areInIncreasingOrder: <)
    }
}

let num = 3;

let arrs = [1,2,3,4,5,6,7,8,9]

arrs.binartSearch(for: num)

extension RandomAccessCollection {
    
    func binartSearch(for value: Element, areInIncreasingOrder:(Element, Element)-> Bool) ->Index?{
        
        guard !isEmpty else {
            return nil
        }
        var left = startIndex
        var right = endIndex
        while left <= right {
            let dis = distance(from: left, to: right)
            let mid = index(left, offsetBy: dis / 2)
            let cir = self[mid]
            if areInIncreasingOrder(value, cir) {
                right = index(before: mid)
            }else if areInIncreasingOrder(cir, value){
                left = index(after: mid)
            }else{
                return mid
            }
        }
        return nil
    }
}

extension RandomAccessCollection where Element : Comparable{
    func binarySearch(for value : Element) -> Index? {
        return binartSearch(for: value, areInIncreasingOrder: <)
    }
}


let string = "a"

let strs = ["a","b","c","d","e","f","g"]

strs[2..<5].binartSearch(for: string, areInIncreasingOrder: <)


//写一个正常的网络请求
func loadUsers(){
    
    let userData = try? Data.init(contentsOf: URL.init(string: "https://api.github.com/authorizations")!)
    
    let jsonRoot = userData.flatMap {
        try? JSONSerialization.jsonObject(with: $0)
    }
    print(jsonRoot ?? "...");
}

loadUsers()


