//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var a = [1,2,3]

let copyA = a

//将 数组的地址 转换成 String,withUnsafeBufferPointer方法 是内存访问函数
//T 代表泛型
func getBufferAddress<T>(Array:[T]) ->String{
//    return Array.withUnsafeBufferPointer({ (Array) -> String in
//        return String(describing:Array)
//    })
    return Array.withUnsafeBufferPointer{ buffer in
        return String(describing:buffer.baseAddress)
    }
}

//通过 地址的打印发现在Swift中, 当进行数组的copy 后, 是值语义的copy,而非引用语义的copy
getBufferAddress(Array: a)
getBufferAddress(Array: copyA)

//只有当 其中一个数组 发生改变时,才会创建新的内存, 这是出于对性能的考量
a.append(4)
getBufferAddress(Array: a)
getBufferAddress(Array: copyA) // copy on write

// swift 与
let b = NSMutableArray(array : [1,2,3,])
let copyB : NSArray = b
let deepCopyB = b.copy() as! NSArray


b.insert(0, at: 0)
copyB
deepCopyB


var arr = [1,2,3,4,5,6]

//循环遍历
//Swift 摒弃掉了 for (int i = 0; i<arr.count; i++) 这种循环方式
arr.forEach{print($0)}

//遍历 数组中的元素 与 对应的下标
//(index, value) 是 一个 Tuple(元组), 是Swift引入的一个新的数据类型,OC中没有
for (index, value) in arr.enumerated() {
    print(index, value)
}


//找到 某一个元素的下标
let oneIndex = a.index{$0 == 2}

oneIndex

//寻找 某个元素 在 String 类型中也适用
var strArr = ["hello", "world", "swift", "is", "good"]

let index_one = strArr.index{$0 == "is"}
index_one



// 数组中的常用操作
var normalArr = [1,2,3,4,5,6]

var squares = [Int]()

//squares 数组 中存放的数据是 normalArr 中每个元素的平方
for value in normalArr{
    squares.append(value * value)
}

squares

// 这种 数组中的逻辑 我们都可以通过 map 去 对其逻辑进行 封装 转换, 从而让代码看起来更优雅
let mapSquares = normalArr.map { (number : Int) -> Int in
    return number * number
}

// extension 可以理解为 OC 中的category, 在swift项目开发中,对于某个类 有常用方法的扩展封装 也可以通过 extension 来完成
//通过 自己实现一个 平方的 map 方法, 充分验证了数组 的 map 只是将一些处理的逻辑封装在了一个函数中而已,并不是什么黑魔法

//Element 代表 数组中 即将要执行操作的元素的替代符
//reserveCapacity 方法是 申明数组时 为了不浪费内存,限制数组长度的函数
//如果明确的知道一个数组的容量大小，可以调用这个方法告诉系统这个数组至少需要的容量，避免在数组添加元素过程中重复的申请内存。
extension Array {
    
    func squareMap<T>(_ transform : (Element) -> T) -> [T] {
        var temp : [T] = []
        temp.reserveCapacity(count)
        for value in self {
            temp.append(transform(value))
        }
        return temp
    }
}

//通过自定义的map 方法 一样也可以实现 想要的操作
let customSquare = normalArr.squareMap { (number : Int) -> Int in
    return number * number
}

//最大元素 和 最小 元素 的方法, 其本质 也是 两个 map 方法
customSquare.min()
customSquare.max()

//第一个元素 与 最后一个元素
customSquare.first
customSquare.last

//过滤条件, 删选符合条件的 元素
customSquare.filter { (number : Int) -> Bool in
    return number > 6
}

//排序, 默认是升序
customSquare.sorted()

//可以通过 by 传入 你想要的排序条件
customSquare.sorted(by: >)

//将数组中的元素合并 成你想要的值, 第一个参数是初始值(这个值是根据你的需求自定义的,并非数组中的元素), 第二个参数是你想要的操作
customSquare.reduce(9, +)


//上面所举的🌰, 一个是展现了Swift 中数组的 map特性 和 它的一些常用的函数, 也了解到了 extension (可以理解为 OC 中的 category)
//最重要的是 所有的操作 都是通过closure(闭包)来参数化对数组的操作行为, 这个是精髓

//上面的 customSquare.reduce(9, +) 只是swift 语法中的一种简写, 实际上还是通过 closure 来参数化 而对 数组进行操作的行为
//和下面的🌰 是相同的 
customSquare.reduce(9) { (initV, number : Int) -> Int in
    return initV + number
}


extension Array {
    func deleteObject(_ predicate : (Element) -> Bool) -> [Element] {
        return filter{!predicate($0)}
    }
    
    func myFilter(_ predicate: (Element) -> Bool) -> [Element] {
        var tmp: [Element] = []
        
        for value in self where predicate(value) {
            tmp.append(value)
        }
        
        return tmp
    }
    
    func allMatch(_ predicate : (Element) -> Bool) -> Bool {
        return !contains{ !predicate($0)}
    }
}




let array = [0,1,2,4,6,8]

array.myFilter {$0 % 2 == 0}

//array.deleteObject{ $0 % 2 == 0}


array.contains{$0 % 2 == 0}

let testArr = [2,4,6,8]

testArr.allMatch{$0 % 2 == 0}











































