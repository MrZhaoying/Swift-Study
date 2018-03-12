//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//@autoclosure
//Swift里允许我们通过@autoclosure来修饰参数类型
//当你需要延后评估某个表达式的值的时候，你就可以考虑这个工具了

//举个例子

let numbers : [Int] = []

if !numbers.isEmpty && numbers[0] > 0 {
    print("continue work")
}

//如果自己编写一个函数来实现 逻辑与的表达式
func judgeAction(_ left: Bool, _ right: Bool) ->Bool{
    guard left else {
        return false
    }
    return right
}

//Fatal error: Index out of range
//当执行函数时,发生了越界错误, 道理很简单
//函数在执行前，要先评估它的所有参数，在评估到numbers[0]的时候, 发生了错误,导致 函数中的guard完全没有被用到
//judgeAction(!numbers.isEmpty, numbers[0] > 0)

//这个时候我们可以通过函数来解决这种情况, 思路:
//我们把通过第二个参数获取Bool值的过程，封装在一个函数里。在评估judgeClosureAction参数的时候，会评估到一个函数类型。我们把真正获取Bool的动作，推后到函数执行的时候。
func judgeClosureAction(_ left:Bool, _ right: () ->Bool) ->Bool{
    guard left else {
        return false
    }
    return right()
}

//这样就可以实现,但在调用的时候 参数必须是一个 {} closure expression
judgeClosureAction(!numbers.isEmpty, {numbers[0]>0})

//如果采用 @autoclosure 来修饰,就可以像一个普通参数一样表述

func judgeAutoclosure(_ left: Bool, _ right: @autoclosure () ->Bool) ->Bool{
    guard left else {
        return false
    }
    return right()
}

//@autoclosure 完美的完成了任务, Swift 果然是屌屌的
judgeAutoclosure(!numbers.isEmpty, numbers[0] > 0)

//再重复一遍功能: @autoclosure的主要应用场景,简单来说，就是当你需要延后评估某个表达式的值的时候，你就可以考虑这个工具了




//escape的概念:
//当一个闭包(closure)当做参数传递进函数里,这个closure一般是需要在这个函数执行完成后执行的, 我们将这样的closure称之为逃逸闭包
//在网络请求完成后需要执行的回调 就可以用逃逸闭包去表示
//Swift的内存管理 依旧是引用计数的原理,  为了保证closure中用到的数据都需要让该closure去捕捉到,从而保证这个closure在执行的时候这些数据不会被释放掉, 所有closure中用到的对象
//其实已经被捕捉(持有), 也就是进行了retain操作, 这样一来,closure内也是极其容易引起循环引用的发生

//逃逸闭包 @escaping
//之所以要使用@escaping来修饰closure参数，是为了时刻提醒你，不要让它们成为脱缰的野马。
//把一个外部的closure传递给@escaping参数的时候，你也要时刻记着：”喔，我可能会创建循环引用，要认真考虑是否需要在closure内使用capture list来避免这个问题。”

//在swift3.0以后, 作为函数参数的closure默认是non escaping属性的,但依旧有两种情况下它一定是 escaping 属性的

/*
 如果closure被封装在一个optional里,它一定是逃逸闭包, escaping closure
 */

//举个例子:
//此时 (() ->Int)?) 肯定是个 escaping closure
func optionClosure(_ x: Int, form: (() ->Int)?) ->Int{
    //解包
    guard let form = form else { return x }
    return form()
}

/*
 有自定义类型的closure属性，默认是escaping的
 */




