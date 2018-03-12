//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//函数, 通常用来 封装逻辑、传参、调用、获取结果等
//基础知识

//func是定义函数的关键字，后面是函数名；
//()中是可选的参数列表, 如果没有参数可传递,可以为空
//()后面，是函数的返回值，如果无返回值,也可以为空 ；
//{}中是函数要封装的逻辑；
func logManName (){
    print("Ying")
}
//函数调用
logManName()

//有参数传递的函数
func sum (x: Int, y:Int){
    print(x + y)
}

sum(x: 1, y: 2)

//有参数传递, 也有返回值的函数, 在参数前面添加 _ 表示在调用的时候可以忽略参数,直接传递值
func sumaction (_ x: Int, _ y: Int) -> Int{
    return x + y
}

let sum = sumaction(2, 3)
print(sum)

//参数 也可以是传递默认值

func mutaction (_ x:Int, of y : Int = 2){
    print(x * y)
}

//直接传 x值, y值用默认的
mutaction(5)
//两个值都传, 可以重新定义y值
mutaction(5, of: 3)

//如果 函数需要传入的参数个数不定时(定义可变长的参数)
//(_ m : Int ...) 表示 可以传入的Int型参数是可变的

func changeLength(_ m : Int ...){
    print(m.reduce(2, +))
}

//传入多个参数
changeLength(1,2,3,4,5,6)

//inout 关键字
// 默认情况下,参数是只读的, 你不能在函数内部修改参数值, 也不能通过函数的参数对外传值

//举个🌰 , 代开注释会发现 修改result 会报错,认为result 不可修改
//func mul(result : Int, _ numbers : Int ...){
//    result = numbers.reduce(1, *)
//    print(result)
//}

//如果 是 用 inout来修饰,就可以被修改了
func mul(result : inout Int, _ numbers : Int ...){
    result = numbers.reduce(1, *)
    print(result)
}

//使用的🌰
var result = 1
mul(result: &result, 2,3,4,5,6)

//在Swift3.0以后,参数名不再是函数签名的一部分
func sumfunc (m : Int, n: Int) -> Int{
    return m + n
}
let fnSum = sumfunc
fnSum(2,3)
sumfunc(m: 2, n: 3)


// 两个函数的类型是兼容的, 都是传递两个Int参数, 返回值为Int类型的函数
print(type(of: fnSum))
print(type(of: sumfunc))

//函数 在 Swift中是一等公民
// 1. 函数可以用来定义变量使用
// 2. 函数可以作为函数参数使用
// 3. 函数也可以作为函数的返回


// 1. 函数可以用来定义变量使用
func sumfunc1 (m : Int, n: Int) -> Int{
    return m + n
}
let fnSum1 = sumfunc1
fnSum1(2,3)

// 2. 函数可以作为函数参数使用
func div (m:Int, n:Int) -> Int{
    return m / n
}
func calaction<T>(_ first:T, _ second:T, _ fn: (T,T) ->T) ->T{
    return fn (first, second)
}

calaction(12, 3, div)

// 3. 函数也可以作为函数的返回
func sumfunc2(_ m:Int) -> (Int) ->Int{
    func innerDiv(_ n: Int) -> Int{
        return m / n
    }
    return innerDiv
}

sumfunc2(15)(3)












