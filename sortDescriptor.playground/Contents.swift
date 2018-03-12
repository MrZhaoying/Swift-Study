//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class student : NSObject {
    @objc var name : String
    var title : String
    @objc var age : Int
    
    
    init(name: String, title:String, age:Int) {
        self.name = name
        self.title = title
        self.age = age
    }
    
    override var description: String{
        return name + "\t" + title + "\t" + String(age)
    }
}

let students : [student] = [
    student.init(name: "name 9", title: "ios develope", age: 20),
    student(name: "name 1", title: "ios", age: 19),
    student(name: "name 2", title: "java", age: 19),
    student(name: "name 3", title: "java", age: 22),
    student(name: "name 4", title: "javas", age: 30),
    student(name: "name 5", title: "java", age: 27),
]

//#keyPath
//#keyPath(Type.property.property.....) 来创建一个 key，就能使用 KVC 的方法 value(forKey:) 、value(forKeyPath:)
//KVO 的方法 addObserver(_:forKeyPath:options:context:)。
let ageDescriptor = NSSortDescriptor(key: #keyPath(student.age), ascending: true)

let nameDescriptor = NSSortDescriptor(key: #keyPath(student.name), ascending: true, selector: #selector(NSString.localizedCompare(_:)))

let descriptorArr = [nameDescriptor, ageDescriptor]

//将 students 数组 进行类型转换后 就可以使用 OC方法
let sortArr = (students as NSArray).sortedArray(using: descriptorArr)

//因为 students bridge 成了 NSArray, 排序后的数组中的元素类型变成了Any, 需要转换为 student 类型
sortArr.forEach(){print($0 as! student)}

//通过 Swift 来实现 排序
//接受两个相同类型的参数并且返回Bool类型
typealias SortDescriptor<T>  = (T,T) -> Bool

//两个string 的比较
let stringSortDescriptor : SortDescriptor<String> = {
    $0.localizedCompare($1) == .orderedAscending
}

let ageSortDescriptor : SortDescriptor<student> = {
    $0.age < $1.age
}

func makeDescriptor<Key, Value>(key: @escaping (Key) ->Value,
                                _ isAscending: @escaping (Value, Value) ->Bool) -> SortDescriptor<Key>{
                                    return {isAscending(key($0), key($1))}
}

let nameSortDescriptor : SortDescriptor<student> = makeDescriptor(key: {$0.name}, {
    $0.localizedCompare($1) == .orderedAscending
})

students.sorted(by: nameSortDescriptor).forEach{print($0)}












