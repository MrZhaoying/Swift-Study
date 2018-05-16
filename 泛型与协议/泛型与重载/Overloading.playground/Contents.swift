//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//理解重载
//重载: 拥有同样的函数名, 但是参数和返回类型不同的多个函数方法, 互相称为重载

//理解泛型与重载的区别

//用简单的例子理解泛型 和 重载
//交换两个数的值
//func swapTwoValues(_ a: inout Int, _ b: inout Int) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}
//var numb1 = 100
//var numb2 = 200
//
//print("交换前数据: \(numb1) 和 \(numb2)")
//swapTwoValues(&numb1, &numb2)
//print("交换后数据: \(numb1) 和 \(numb2)")

//
//func swapTwoValues(_ a: inout String, _ b: inout String) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}
//
//func swapTwoValues(_ a: inout Double, _ b: inout Double) {
//    let temporaryA = a
//    a = b
//    b = temporaryA
//}
//
//var str1 = "Swift"
//var str2 = "Java"
//
//print("交换前数据: \(str1) 和 \(str2)")
//swapTwoValues(&str1, &str2)
//print("交换后数据: \(str1) 和 \(str2)")
//
//var double1 = 20.0
//var double2 = 30.0
//
//print("交换前数据: \(double1) 和 \(double2)")
//swapTwoValues(&double1, &double2)
//print("交换后数据: \(double1) 和 \(double2)")

//泛型方法
func swapTwoValues<T>(_ a: inout T, _ b: inout T){
    let temporaryA = a
    a = b
    b = temporaryA
}

var double1 = 20.0
var double2 = 30.0

print("交换前数据: \(double1) 和 \(double2)")
swapTwoValues(&double1, &double2)
print("交换后数据: \(double1) 和 \(double2)")


var str1 = "Swift"
var str2 = "Java"

print("交换前数据: \(str1) 和 \(str2)")
swapTwoValues(&str1, &str2)
print("交换后数据: \(str1) 和 \(str2)")


class OverloadObject {
    
    //自由函数的重载
    func raise(_ base : Double, to exponent: Double) -> Double {
        return pow(base, exponent)
    }
    
    func raise(_ base : Float, to exponent: Float) -> Float {
        
        print("调用了 Float的方法")
        return powf(base, exponent)
    }

}

//当 raise 函数被调用时，编译器会根据参数和/或返回值的类型为我们选择合适的重载
let overload = OverloadObject()

let double = overload.raise(2.0, to: 3.0)
type(of: double)

//例子1
//如果我们明确定义 返回值 float的类型为Float, 它就会调用func raise(_ base : Float, to exponent: Float) -> Float
//let float = overload.raise(2.0, to: 3.0)

let float1 : Float = overload.raise(2.0, to: 3.0)
type(of: float1)

//重点1:
//Swift有一套复杂的重载函数使用规则优先级,会根据函数是否是泛型和传入的参数是怎样的来确定会调用哪个函数,
//但非通用函数会优先于通用函数被调用;


//例子2
//通用的泛型函数
func log<View:UIView>(_ view : View){
    print("it is a \(type(of: view)), frame : \(view.frame)")
}

//非通用的函数
func log(_ label : UILabel){
    
    let text = label.text ?? "empty text"
    
    print("it is a \(type(of: label)), text : \(text)")
}


let label = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 32))
label.text = "Password"
//当传入的是 label时, 会调用 非通用 func log(_ label : UILabel) 函数
log(label)

//当传入的是 button时, 会调用 通用 func log<View:UIView>(_ view : View) 函数
let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
log(button)

//所以是根据传入的参数和是否为泛型函数来决定重载调用的方法


//重点3:
//特别注意，重载的使用是在编译期间静态决定的。
//也就是说，编译器会依据变量的静态类型来决定要调用哪一个重载，而不是在运行时根据值的动态类型来决定

let views = [label, button]

for view in views {
    log(view)
}

/*
 从打印的日志可以看到, 即便是label, 也是调用了func log<View:UIView>(_ view : View) 函数,
 而不是动态的去匹配func log(_ label : UILabel)
 it is a UILabel, frame : (20.0, 20.0, 200.0, 32.0)
 it is a UIButton, frame : (0.0, 0.0, 100.0, 50.0)
 */


//重点4:在Swift中, 可以通过重载函数的方式自定义运算符,运算符也可以被重载;
//对于重载的运算符, 类型检查器会去使用非泛型的重载方法, 而不使用泛型函数的重载

//例子:自定义一个求幂的运算符 **
//Swift 源码中对运算符的定义
precedencegroup ExponentiationPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}
//告诉Swift, `**` 是一个 `infix` 运算符，也就是需要两个操作数，运算符在两个数的中间
infix operator **: ExponentiationPrecedence

func **(lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}

func **(lhs: Float, rhs: Float) -> Float {
    return powf(lhs, rhs)
}

//现在 ** 运算符 和 上面的raise函数就是一个功能了
2.0 ** 3.0

//现在我想实现一个支持 Int的 求幂运算, 可以通过一个泛型函数来实现

//BinaryInteger 协议 提供所有integer数据类型的基础方法
func **<I : BinaryInteger>(lhs:I, rhs:I) ->I{
    
    let result = Double(Int64(lhs)) ** Double(Int64(rhs));
    
    return I(result);
}

//这样是会报错的, 因为这个时候 ** 发生了歧义
/*
发生歧义是因为编译器忽略了整数的泛型重载，因此它无法确定是去调用 Double 的重载还是 Float 的重载，
因为两者对于整数字面量输入来说，是相同优先级的可选项 (Swift 编译器会将整数字面量在需要时自动向上转换为 Double 或者 Float)，
所以编译器报错说存在歧义。
 */
//2 ** 3

//这个时候 只有你明确的提供返回值类型 或者明确的声明一个参数的类型, 就可以了

let result : Int = 2 ** 3


















