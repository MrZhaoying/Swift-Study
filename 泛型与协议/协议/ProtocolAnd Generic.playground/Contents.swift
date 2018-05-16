//: Playground - noun: a place where people can play

import UIKit

//类和方法
class Person {
    func alive() -> Bool {
        return true;
    }
    
    func canEat() {
        
    }
    func canRun() {
        
    }
    func canSpeak() {
        
    }
}

func isLive(_ p : Person)  {
        p.alive()
        p.canEat()
        p.canRun()
        p.canSpeak()
}

let p : Person = Person()

isLive(p)


protocol PersonBehavior {
    
    func alive() -> Bool
    
    func canEat()
    
    func canRun()
    
    func canSpeak()
}

//Man 类遵从PersonBehavior协议, 并实现协议方法
class Man : PersonBehavior {
    
    func alive() -> Bool {
        print("活着")
        return true;
    }
    
    func canSpeak() {
        print("能说")
    }
    
    func canRun() {
        print("能跑")
    }
    
    func canEat() {
        print("能吃")
    }
}

class Woman : PersonBehavior{
    func alive() -> Bool {
        print("活着")
        return true;
    }
    
    func canSpeak() {
        print("能说")
    }
    
    func canRun() {
        print("能跑")
    }
    
    func canEat() {
       print("能吃")
    }
}


func isLive<M : PersonBehavior>(_ person : M){
    person.canSpeak()
    person.alive()
    person.canRun()
    person.canEat()
}

let man = Man()
let woman = Woman()

isLive(man)
isLive(woman)













