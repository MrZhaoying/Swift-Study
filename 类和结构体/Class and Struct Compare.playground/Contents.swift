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
        //引用类型 就不可以
//        self = to // error
    }
}

struct PointValue{
    var x : Int
    var y : Int
  
    //充分说明了这是一个 值类型, 直接可以赋值 给 self
  mutating func move(to:PointValue) {
       self = to //right
    }
}

let pointR = PointRef(x: 10, y: 10)

//结构体 有 自动初始化
let pointV = PointValue(x: 12, y: 12)

//pointV.y = 16 值类型的常量的属性值是不可以修改的

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

//一般情况下, 我们都会为Class designated一个init方法, 并且初始化它的所有属性
class Person {
    var name : String
    var age : Int
    init(name :String, age:Int) {
        self.name = name
        self.age = age
    }
}

//便利 初始化
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

//通过 guard 来处理 参数出现错误的情况, 避免因为错误的数据类型引发初始化时发生不可控的情况,这就是我理解的failable init 方法,提供更安全的方式
let woman = Woman(at: ("memng", "18"))

//理解 two - phase init
class Point2d {
    var x : Double
    var y : Double
    
    init(x: Double, y : Double)  {
        self.x = x
        self.y = y
    }
}

let point : Point2d = Point2d(x: 2, y: 3)

class Point3d : Point2d{
    var z : Double
    
    init(x: Double = 0, y: Double = 0, z: Double = 0) {
        
        self.z = z
        super.init(x: x, y: y)
        
        self.initRound(x: x, y: y, z: z)
    }
    func initRound(x: Double, y: Double, z: Double) {
        self.x = round(x)
        self.y = round(y)
        self.z = round(z)
    }
    
}




//对于继承, 我们需要进一步的探讨

//探讨1: 派生类会继承它的基类的方法, 那么对于init方法会继承吗?

//理论上说 派生类不会主动继承其基类的init方法,
//举个例子
class Developer : Person{
//    var proLaunage : String //不会 继承 基类的 init 方法
    var progLaunage : String = "Swift"
    
}
//let iosDev = Developer()  // error: class 'Developer' has no initializers

//当 proLaunage有默认值时, 继承了ji'le
let iosDev = Developer(name: "luoColumn", age: 18)


//虽然当派生类没有定义任何designated init 方法时, 会从基类继承基类的 designnated init 方法,但由于即便继承了,也完不成其自有变量的初始化, 所以 派生类也就不会自动继承其基类的初始化方法

//但如果我们给 Developer类的 progLaunage 给一个默认值, 它就会继承Person的 designated init 方法, 上面的例子也证实了这一点

//探讨2:关于 init 方法的继承, 还有一个原则:  如果一个派生类定义了所有基类的designated init，那么它也将自动继承基类所有的convenience init

class Teacher : Man{
    var height : Double
    
    init(name:String, age:Int, height:Double) {
//        先初始化self.height，然后再调用super.init初始化基类的成员, 如果顺序颠倒, 就会发生错误
        self.height = height
        super.init(name: name, age: age)
    }
    
    override init(name: String, age: Int) {
        self.height = 175
        super.init(name: name, age: age)
    }
}

let teacher = Teacher(name: "DaBig", age: 18)

//只要 override init 了 基类的 designated init方法, 就会自动继承它的 convenience init 方法
let teacher_1 = Teacher(at: ("memng", 18))

//所以，只要派生类拥有基类所有的designated init方法，他就会自动获得所有基类的convenience init方法。

//好的API应该更容易用对，而更不容易用错

//永远不要重定义继承而来的默认参数

class Human {
//    var name : String
//    var age : Int
//
//    init(name : String, age:Int) {
//        self.name = name
//        self.age = age
//    }
    
    func nameSetting(name : String = "Swift") {
        
    }
}

class Kid : Human{
    override func nameSetting(name: String = "Java") {
       print("name is \(name)")
    }
}

class Younger : Human{
    override func nameSetting(name: String = "Python") {
        print("name is \(name)")
    }
}

//当 kid 和 younger 分别是 他们具体的对象类型时, 修改默认值是没问题的
let kid = Kid()
kid .nameSetting() //name is Java
let younger = Younger()
younger.nameSetting() //name is Python

// 利用多态来动态选择调用的方法时, 结果却都是调用了基类中的 nameSetting方法
let human_kid : Human = Kid()
let human_you : Human = Younger()


human_kid.nameSetting() //name is Swift
human_you.nameSetting() //name is Swift

//在Swift里，继承而来的方法调用是在运行时动态派发的，Swift会在运行时动态选择一个对象真正要调用的方法。但是，方法的参数，出于性能的考虑，却是静态绑定的，编译器会根据调用方法的对象的类型，绑定函数的参数

//当默认参数和需要重写的方法发生冲突时，更好的做法是用一个无法被重写的方法在前面充当API, 可以通过 extension 来解决问题。永远也不要改写继承而来的方法的默认参数，因为它执行的是静态绑定的语义。













































