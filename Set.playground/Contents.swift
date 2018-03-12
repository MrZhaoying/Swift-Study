//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//初始化, 及常见方法都和Array 相同
var vowel : Set <Character> = ["a","e","i","o","u"]

vowel.count
vowel.isEmpty
vowel.contains("u")
vowel.remove("a")
vowel.insert("a")
vowel.removeAll()

//SetAlgebra Protocol 数据集 操作协议
/*
 Set : 集合是 Swift中 唯一支持 SetAlgebra 协议的 Collection 类 数据结构,
 SetAlgebra的数据集操作可以高效的完成如 交集, 联合,减法等操作,
 在标准库中,任何可 hash 类型元素的类型, 都可以 通过数据集操作 做一些事情
 */

//必须 在声明时 有明确的类型, 如果 不明确声明 是 Set, 则会默认是 Array
var set_one : Set = ["a","e","i","o","u"]
var set_two : Set = ["a","o","e", "i","u", "b","p", "m", "f"]

let insertSet = set_one.intersection(set_two) //交集
let unionSet = set_one.union(set_two)//合并
let symmetridiff = set_one.symmetricDifference(set_two)//找出不同的元素
let subtractSet = set_one.subtracting(set_two)//做差, a 中 不在 b 存在的元素


//通过 Set 的 特性 扩展 Collection 类型的数据结构 自定义 去重
extension Sequence where Iterator.Element : Hashable {
    func unique() -> [Iterator.Element] {
        //定义一个 存放 类型为 迭代器中元素的 Set
        var result : Set<Iterator.Element> = []
        //过滤条件
        return filter{
            if result.contains($0) {
                return false
            }else{
                result.insert($0)
                return true
            }
        }
    }
}

//数组 可 去重 例子
let arr_three = [1,2,2,3,3,3,4,5,6,6,7,7,8]
arr_three.unique()


















