//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//if ... else if ... else
var color = "white"
var color_one = ""

if color == "white" {
    color_one = "red"
}else if color == "red"{
    color_one = "red"
}else{
    color_one = "black"
}

//if ... else 与 switch
//在 Swift 中 swicth 的条件 可以是 String
switch color {
case "white":
    color_one = "red"
case "red":
    color_one = "white"
case "black":
    color_one = "black"
default:
    color_one = "green"
}

//三段式 for 循环在swift 中被放弃

let arrValue = [1,2,3,4,5,6,7,8]

for number in arrValue {
    print(number)
}

for number in 1...10 {
    
    if number % 2 != 0 {
        //跳出本次循环,继续下次循环
        continue
    }
    if number > 6 {
        //跳出该循环
        break
    }
    
    print(number)
}

//while 循环 和 do ... while 循环
var index = 0
while index < 10 {
    index += 1
    print(index)
}

repeat {
    print(index)
    index -= 1
}while index > 0

//以上就是 基础的条件语句

//在 Swift 中, 可以通过 case 来 简化 我们需要做判断的语句, 来完成更多场景下的运用

let name = "mengmeng"
let age = 18
//以前是这样的
if name == "mengmeng" && age == 18{
    print("true")
}
//现在是这样的
if case ("mengmeng", 18) = (name, age) {
    print("true")
}


//原点
let originPoint = (x: 0, y: 0)
let point_one = (x:0,y:0)
//比较
if point_one.x == originPoint.x && point_one.y == originPoint.y {
    print("same is origin")
}

//通过  定义一个 tuple 来做比较
if case (0, 0) = point_one {
    print("same is origin")
}

//switch 的 条件 非常多元化, tuple中(_, 0) 和 (0,_) 的条件 表示只和 tuple中的某一个值进行比较
switch point_one {
case (0,0):
    print("same is origin")
case (_, 0):
    print("on x != point_one x")
case (0, _):
    print("on y != point_one y")
default:
    break
}

let array = [2,3,4,5,6,2,3,4,2,2]
//等于 2 时才进入循环
for case 2 in array {
    print("times = 2")
}

//在Swift中 也可以通过 where 来让条件判断做更多复杂的东西
//举个🌰
//以前是这样写的
for number in 1...15 {
    if number % 2 == 0 {
        print(number)
    }
}
//现在可以结合 where ,这样写
for number in 1...15 where number % 2 == 0 {
    print(number)
}

//还有更复杂的

enum Score {
    case A
    case B
    case C(score : Float)
}
let level_c = Score.C(score: 85)

switch level_c {
case .C(let score) where score <= 60:
    print("C")
case .C(let score) where score >= 90:
    print("A")
case .C(let score) where score > 60 && score < 90:
    print("B")
default:
    print("0 score")
}

//在 Swift 中, switch语句是不会向下贯通的, 我们需要通过 , 将分支条件串联到一起
let score = Score.A

//错误的姿势 - switch语句是不会向下贯通的
//switch score {
//case .A:
//    print("A")
//case .B:
//case .C:
//    print("Not A")
//default:
//    print("NO level")
//}

//正确的姿势
switch score {
case .A:
    print("A")
case .B, .C:
    print("Not A")
}

















