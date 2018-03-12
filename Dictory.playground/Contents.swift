//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum dictionaryType{
    case bool(Bool)
    case number(Int)
    case text(String)
}
//创建一个字典,并赋值
let dict_one : [String : dictionaryType] = [
    "uid" : .number(123456),
    "name" : .text("swift"),
    "isgood" : .bool(true)
]

var template = dict_one

let dict_two : [String : dictionaryType] = [
     "title" : .text("merge dictionary"),
    "uid" : .number(110)
]


//Sequence sequence 协议, 序列协议是大多数集合类数据结构都遵循的协议, Array, Set, Dictionary 都遵循了Sequence Protocol

//理解 Iterator Protocol (迭代器协议)
/*
 它是一个和 Sequence Protocol(序列协议)紧密关联的一种协议, 序列通过创建迭代器来提供对其元素的访问,
 迭代器跟踪它的迭代过程, 并通过序列前进时返回一个元素
 */
//举个🌰
let Colleagues = ["zhangjin","luoqi","wangbing","pangrengmeng","zhaoying"]

for name in Colleagues {
    print(name)
}
//其实 for in 循环的背后 就是 Iterator 来完成的
var nameIterator = Colleagues.makeIterator()
while let name = nameIterator.next(){
    print(name)
}

//extension 扩展
/*
 有了上面对Sequence 和 Iterator 的解释, 理解 merge方法就应该简单的多了,
 它是通过比较,将任何形式的序列,
 只要两个元素(key 和 value)的类型 和 Dictionary相同, 他们的数据就可以合并
 */
extension Dictionary {
    mutating func merge<T:Sequence>(_ sequence : T)
        where T.Iterator.Element == (key : Key, value : Value){
        sequence.forEach{self[$0] = $1}
    }
}

//实例 合并两个参数类型相同的 Dictionary
template.merge(dict_two)
print(template)

//实例 合并一个数组到 字典中
let arr : [(key : String, value : dictionaryType)] = [
    (key : "uid", value : .number(666)),
    (key : "title", value:.text("arr_title"))
]

var template1 = dict_one
template1.merge(arr)


//Dictionary 的 map 行为
template1.map{$1}














