//: Playground - noun: a place where people can play

import UIKit

//struct and class



//比较 struct 和 class
//Swift中的class和struct有许多共同之处。两者都可以：
/*
定义属性以存储值

定义提供功能的方法

使用下标语法定义下标以提供对其值的访问

定义初始化程序以设置其初始状态

扩展到超出默认实现范围的功能

符合协议以提供某种标准功能
*/


//class具有struct不具有的其他功能：
/*

继承使一个类能够继承另一个类的特性。

类型转换使您能够在运行时检查和解释类实例的类型。

去初始化器使类的一个实例释放它分配的任何资源。

引用计数允许对一个类实例的多个引用

 */

//重要区别:
//struct在代码中传递时总是被复制，并且不使用引用计数。
//class 是引用类型, struct 是值类型

//代码示例
struct PersonStruct{
    var name : String
    var age : Int
}

class PersonClass{
    var name : String = "Swift"
    var age : Int = 4
    
    //class 必须实现初始化方法 或者给它拥有的变量一个初始值
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
}

//Memberwise Initializers for Structure Types
//Struct 会根据 它所拥有的变量  自带一个默认的初始化方法 , 我们将这个称谓Memberwise Initializers
let person_1 = PersonStruct(name: "Swift", age: 4)

//class 实例不接收默认的成员初始化器, 因此我们需要在 class 中实现更加详细的 初始化, 就像 PersonClass 所展现的一样
//let person_2 = PersonClass(name: "Swift", age: 4)
let person_3 = PersonClass()

//基本类型在swift中,  整数、浮点数、布尔值、字符串、数组和字典中都是值类型，并且在后台实现为struct。


//enum 类型
//enum 定义了一组相关值的通用类型，并使您能够在代码中以类型安全的方式处理这些值。

//官方的例子:
//可以将不同的值通过不同的case 来表述
enum CompassPoint {
    case north
    case south
    case east
    case west
}

//也可以通过 一个case, 但不同的值都可以用 逗号(,)分割的形式来表述
//在Swift中, enum并不是类似于 Objective-C 中, 枚举并不默认代表一组整数值, case自身就是enum的值
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//打印出来并不是 0, 而是 mercury
let merc = Planet.mercury
print(merc)


//也可以在 enum的定义时 给它绑定一个值
enum Direction : Int {
    case north = 1
    case south = 2
    case east = 3
    case west = 4
}

//获取 它本身 和 它的值
let north = Direction.north
let northValue = Direction.north.rawValue
print(north, northValue)


//Associated value
//定义enum时, 可以像 Direction中这样给它绑定值, 但不是唯一的绑定值的方法, 也可以像下面这样 通过()中设置关联值, 可以是1个,也可以是多个, 这样的值叫做associated values
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var bar_1 = Barcode.qrCode("Swift")
var bar_2 = Barcode.upc(1, 2, 3, 4)

//在 Swicth 中的使用案例:
switch bar_1 {
case .upc(let a, let b, let c, let d):
    print(a, b, c, d)
case let .qrCode(message):
    print(message)
}






