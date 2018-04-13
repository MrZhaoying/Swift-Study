//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



//TestView 注册了一个delegate, 为TestDelegate, 但并没有仅仅针对class去遵从, struct也可以遵从
protocol TestDelegate {
    mutating func buttonPressed(at index : Int)
}

//TestView 类 的stop方法会触发delegate
class TestView {
    var buttonTitle : [String] = ["stop", "continue"]
    var delegate : TestDelegate?
    
    func stop() {
        delegate?.buttonPressed(at: 1)
    }
}

//正常套路的 delegate的实现

//class TestViewController : TestDelegate {
//
//    var testView : TestView!
//
//    init() {
//        self.testView = TestView()
//        self.testView.delegate = self
//    }
//
//    func buttonPressed(at index: Int) {
//        print("stop player")
//    }
//}

//模拟触发delegate 方法, 每次触发都会打印一次stop player
//let testVC = TestViewController()
//testVC.testView.stop()
//testVC.testView.stop()
//testVC.testView.stop()
//testVC.testView.stop()
//testVC.testView.stop()
//testVC.testView.stop()



/*
 Swift 的 mutating 关键字修饰方法是为了能在该方法中修改 struct 或是 enum 的变量
 所以如果你没在接口方法里写 mutating 的话，别人如果用 struct 或者 enum 来实现这个
 接口的话，就不能在方法里改变自己的变量了
 */
//让一个结构体来遵循并实现TestDelegate
//PressConter这个结构体遵循了TestDelegate, 实现了TestDelegate 的delegate 方法

struct PressConter : TestDelegate{
    //count 属于 struct PressConter 自己的变量, 必须由mutating 关键词来修饰
    var count = 0
    mutating func buttonPressed(at index: Int) {
        self.count += 1
    }
    
}
//TestViewController 类中的testView 注册的TestDelegate 由PressConter类来实现
class TestViewController {

    var testView : TestView!
    
    //结构体
    var counter : PressConter!

    init() {
        self.testView = TestView()
        self.counter = PressConter()
        
        self.testView.delegate = self.counter
    }
}

//模拟触发 delegate 方法
// 实例化一个TestViewController对象,并且触发它的testView的stop方法 ,理论上
let testVC = TestViewController()
testVC.testView.stop()
testVC.testView.stop()
testVC.testView.stop()
testVC.testView.stop()
testVC.testView.stop()
testVC.testView.stop()

//发现 此时count 是 0
print(testVC.counter.count)

/*
 这是因为PressCounter是一个值类型，当我们执行self.testView.delegate = self.counter
 时，delegate实际上是self.counter的拷贝，它们引用的并不是同一个对象，因此调用stop()的时候，
 增加的只是self.testView.delegate，而不是self.counter。
*/

/*
 因此:
 去掉delegate protocol的class约束，并不是一个好主意，这不仅让class类型在实现protocol的时候引入了strong reference；
 而对于struct类型来说，哈，它原来根本就不配做个delegate。
 */

//此时 才会得到 正确的count 6
print((testVC.testView.delegate as! PressConter).count)







