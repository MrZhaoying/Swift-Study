//: Playground - noun: a place where people can play

import UIKit


//在程序运行前,我们需要让编译器强制我们处理可能发生的错误,这样才能最大程度的保证程序的健壮性,于是我们应该竟可能的保证我们代码中 传入/返回的值是正确的
//以一个函数为例:
//作为一个函数的返回值,它是一个独立的类型, 面对所有成功的情况.这个类型需要包含正确的结果, 对于所有出现失败/错误的情况,这个类型需要用一个值来区分与正确的结果不同的类型

//Optional
//Optional是swift不同于C以及Objective-c的一种新概念。引进了这个概念之后，我们可以把类型分为普通类型（例如, String, Array ...）和可选类型（Optional Type）。
//swift中使用普通类型表示值一定存在，用可选类型（Optional Type）来表示其所对应的值可能存在可能为nil。

//定义了一个Optional类型的常量
let number : Int? = 1

//第一种解包方式, 通过 if let 这样的表达式 解包 (是安全的)
if let number = number {
    print(number)
}

//第二种: 通过! 强制解包(是不安全的), 强行读取optional变量中的值，此时，如果optional的值为nil就会触发运行时错误
if number != nil {
    print(number!)
}

//如果在一个函数内部多次调用一个需要解包的参数时, 我们可以通过 使用guard简化optional unwrapping 来一次性处理,而不需要多次的进行 if let 解包

//这是一个需要在内部多次使用的例子, 每次都用 if let 安全解包,显得代码很臃肿
func arrayForEach(array:[Int]){
    
    if let first = array.first {
        print(first)
    }
    
    if let first = array.first {
        print("还需要再次使用\(first)第一个元素")
    }
    
    if let first = array.first {
        print("还需要再次使用第一个元素\(first)")
    }
}
//第三种: 通过guard 来安全解包 的使用例子
func arrayGuard(array: [Int]){
    guard let first = array.first else {
       print("nil")
       return
    }
    print(first)
    print("还需要再次使用\(first)第一个元素")
    print("还需要再次使用第一个元素\(first)")
}

//一个特殊情况
//在Swift里，有一类特殊的函数，它们返回Never，表示这类方法直到程序执行结束都不会返回。Swift管这种类型叫做uninhabited type。
//一般使用这种情况的并不多, 一种是在crash前, 还有一种是在进程生命周期内需要一直执行的方法 ,其返回值可能会是Never

//例子
func toDo(item: String?) -> Never {
    guard let item = item else {
        fatalError("Nothing to do")
    }
    fatalError("Implement \(item) later")
}

//在理解了 Optional 类型后,我们就可以利用Optional的特性,利用编译器对optional的识别机制来为变量的访问创造一个安全的使用环境

//在例子中我们 可以通过 optional 的特性来保证 返回的值肯定是安全的
func arrayFirstToString(array:[Int]) ->String?{
    let firstValue : Int
    if let first = array.first {
        firstValue = first
    }else{
        return nil
    }
    return String(firstValue)
}

//在Optional 中 ? 和 ?? 的使用
//Optional Chaining (可选链接) ? Optional Chaining 可以作为强制解包的替代品

//在Swift中, 只要一个方法返回optional类型，我们就可以一直通过 ?.操作符 把调用串联下去, optional在串联的时候,可以对前面返回的optional进行解包, 如果结果非nil就继续向后调用, 否则就返回nil
//因此，绝大多数时候，如果你只需要在optional不为nil时执行某些动作，optional chaining可以让你的代码简单的多

//例子:

class Man{
    var mother : Mother?
}
class Mother{
    var name = "Mother"
}
let joy = Man()

// 在Man类中有一个变量 mother 是一个 optional 类型, 我们在调用时  采用了 optional chaining 的方式, ?.
let motherName = joy.mother?.name

/*
由于 Man的 mother变量是 optional 类型, 所有默认初始化为nil, 即便 Mother类有一个Normal 类型的变量 name,且有值为 "Mother",此时, 由于Man的mother默认初始化是nil,所以 通过optional chaining joy.mother?.name 的值依旧是nil, 说明当调用到 ?. 时,由于前面是nil,所有并没有再往后继续调用, 这就可以理解为一次解包, 是安全的, ?. 起到的作用和 下面的示例代码起到了同样的作用, 但极大的简化了代码
 这就是 optional chaining 的理解
 */
if let name = joy.mother?.name {
    print(name)
}else{
    print("Unable to know the motherName")
}

//optional chaining 也是可以多级调用的, 只要前一级得到的是一个 optional类型,就可以通过 ?. 的方式继续往下调用
//我们看一下 apple 的文档中的示例代码
class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

let Ying = Person()
//只要前一级返回的是一个 optional 值, 就可以 通过 optional chaining 往下调用
if let buildIdentifier = Ying.residence?.address?.buildingIdentifier() {
    print(buildIdentifier)
}else{
    print("buildIdentifier is nil")
}








