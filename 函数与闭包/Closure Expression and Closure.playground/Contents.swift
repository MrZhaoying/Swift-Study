//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//Closure 和 Closure expression

//Closure expression 就是函数的一种简写形式, 可以用来当做函数的参数来使用

func closurefunc(m : Int) -> Int{
    return m * m
}

let closureExpression = {(m:Int) -> Int in
    return m * m
}

closurefunc(m: 5)
closureExpression(5)

//上面例子中 计算得到的结果是相同的, 而第二种定义中的 {} 就是一个ClosureExpression,
//可以理解为 ClosureExpression 只是把一个函数的 参数, 返回值 以及函数的实现 都写在了一个{}中

//可以作为函数的参数来使用? 那是必须的
let numbers = [1,2,3,4,5,6]

numbers.map(closurefunc)
numbers.map(closureExpression)

//那疑问来了, 可能觉得第二种的写法看起来很复杂,为什么说 它是函数的一种简写形式呢
//如果将上面的这个 map 中的 closure expression 展开来看:
//完整的应该是这样的:
numbers.map { (m: Int) -> Int in
    return m * m
}

//由于 Swift 有类型的推断的实现, 所有可以根据 numbers 中的元素类型 推断函数参数和返回值的类型
//于是可以简化为
numbers.map { m in return m * m }

//如果 closure rxpression 中只有一条语句, 可以自动将这个语句的值作为返回值
//于是可以简化为
numbers.map { m in m * m }

//在 Swift中, 参数命名不作为函数签名的一部分, 如果你认为 参数命名不重要, 还可以简化为:
numbers.map {$0 * $0}

//这样 就可以展现出 用 closure expression 在函数中做上下文, 变得方便多了,写起来更简单

//Closure : a closure is a record storing a function together with an environment
//一个函数加上它所 捕获的变量, 就是一个 closure

func makeCounter() -> () -> Int{
    var value = 0
    return {
        value += 1
        return value
    }
}

let mackCounter1 = makeCounter()

print(mackCounter1())
print(mackCounter1())
print(mackCounter1())
print(mackCounter1())
print(mackCounter1())
print(mackCounter1())

//通过 打印时的调用,我们可以观察打印台 发现 打印的数值在叠加 ,这说明 makeCounter 方法返回后, 虽然 value 已经离开了它的作用域, 但多次调用时 value 的值还是进行了累加,
//makeCounter 返回的函数 捕获了makeCounter 内部的变量 value


//归并排序
extension Array where Element : Comparable {
    mutating func mergeSort(_ begin: Index, _ end: Index){
        //两个及以上的数字才可以排序
        if end - begin > 1 {
            let mid = (begin + end) / 2
            mergeSort(begin, mid)
            mergeSort(mid, end)
            merge(begin, mid, end)
        }
    }
    
    private mutating func merge(_ begin: Index, _ mid: Index, _ end: Index){
        var temp : [Element] = []
        var i = begin
        var j = mid
        
        while i != mid && j != end {
            if self[i] < self[j]{
                temp.append(self[i])
                i += 1
            }else{
                temp.append(self[j])
                j += 1
            }
        }
        temp.append(contentsOf: self[i..<mid])
        temp.append(contentsOf: self[j..<end])
        replaceSubrange(begin..<end, with: temp)
    }
}

var megreNumbers = [1,3,2,5,6,8,4]

megreNumbers.mergeSort(megreNumbers.startIndex, megreNumbers.endIndex)








