//: Playground - noun: a place where people can play

import UIKit

class PointRef {
    var x : Int
    var y : Int
    
    init(x : Int, y : Int) {
        self.x = x
        self.y = y
    }
    
    func move(to : PointRef) {
        self.x = to.x
        self.y = to.y
        
//        self = to // error
    }
}

struct PointValue{
    var x : Int
    var y : Int
    
  mutating func move(to:PointValue) {
       self = to //right
    }
}

let pointR = PointRef(x: 10, y: 10)

let pointV = PointValue(x: 12, y: 12)

//pointV.y = 16 值类型的常量 的属性值是不可以修改的

pointR.x = 12 //引用类型的常量的属性值是可以修改的

//引用类型默认是可以修改的, 因为引用类型关注的是对象本身, 而并非是引用的值,因此它的属性默认是可以修改其值的

var pointR1 = pointR
var pointV1 = pointV

//修改 R1, R也一起被修改
pointR1.x = 16
print(pointR.x)

//修改 V1的值, V的值并没有发生改变
pointV1.y = 20
print(pointV.y)

//回头再去看 class 与 struct 中两个 move方法的差别, 值类型的是可以直接 通过 = 来赋值的, 但引用类型不可以

//这就是 值类型和引用类型在语义上的差别, 值类型的赋值只是简单的内存拷贝后,生成新的值
//因此
//在class的方法里，self自身是一个常量，我们不能直接让它引用其它的对象。
//修改一个struct的本意，实际上是你需要一个全新的值。


//Class 的 init 方法

//在Swift里，这种真正初始化class属性的init方法，叫designated init，它们必须定义在class内部，而不能定义在extension里，否则会导致编译错误。

//只有给 它的变量都设置一个初始值, Swift就会认为 它有了init方法
class Student {
    var name : String = "Swift"
    var age  : Int = 4
}
//声明一个常量 对象
let student = Student()

//但这样还是不可以的
//let student1 = Student(name : "ceshi", age : 20)

//一般情况下, 我们都会为Class designated一个init方法, 并且初始化它的所以属性
class Person {
    var name : String
    var age : Int
    init(name :String, age:Int) {
        self.name = name
        self.age = age
    }
}

//convienience init

class Man {
    var name : String
    var age : Int
    convenience init(at:(name:String, age:Int)){
        self.init(name : at.name, age : at.age)
    }
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
}

//可以将参数以 Toupe / 合适的形式传入初始化方法,有更好的语义的表达
let man = Man(at: ("洛奇", 18))

//但并不是我们每次得到的参数都可以直接转换成 class 中的属性,有可能参数并不是我们想要的类型
//这个时候 failable init 就出现了
class Woman {
    var name : String
    var age : Int
    convenience init?(at:(String, String)){
        guard  let age = Int(at.1) else { return nil }
        self.init(name : at.0, age : age)
    }
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
}

//通过 guard 来处理 参数出现错误的情况, 避免因为错误的数据类型引发初始化时发生不可控的情况
let woman = Woman(at: ("memng", "18"))



























