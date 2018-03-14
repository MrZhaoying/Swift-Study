//: Playground - noun: a place where people can play

import UIKit

// 关于 引用循环
//引用循环问题，只发生在引用类型的对象之间。只有引用类型的对象，才接受ARC机制的管束, 值类型是不会有循环引用问题的

//两个强引用对象之间的彼此引用,会导致引用循环问题

//举个例子:

class Boy {
    var name : String
    var girlFriend : Girl?
    var room : Room //怎么能没房子?

    init(name: String, room:Room) {
        self.name = name
        self.room = room
    }
    
    //释放
    deinit {
        print("Boy \(name) is being deinit.")
    }
}

class Girl {
    var name : String
    weak var boyFriend : Boy? //这样 用weak来修饰, 就可以打破循环,解决问题
   
    
//    var boyFriend : Boy? //这样会导致 循环引用

    init(name : String) {
        self.name = name
    }
    
    //释放的方法
    deinit {
        print("Girl \(name) is being deinit.")
    }
}

class Room {
    var street : String
    var owner : Boy?
    
    init(street : String) {
        self.street = street
    
    }
}


var room : Room? = Room(street: "浦东大道")


var boy : Boy? = Boy(name: "Swift", room:room!)
boy = nil // 这个时候 boy 会被释放, 看打印台

var girl : Girl? = Girl(name: "Objective-c")

girl = nil // 这个时候 girl 会被释放, 看打印台


var room_1 : Room? = Room(street: "nancao road")


var boy_1 : Boy? = Boy(name: "Java", room: room_1!)
var girl_1 : Girl? = Girl(name: "Test")

boy_1?.girlFriend = girl_1

girl_1?.boyFriend = boy_1

//两个都被置为 nil, 但却没有被释放, 永远留在了内存中
boy_1 = nil
girl_1 = nil

//如何 打破循环, weak 依然可以解决这个问题, 属性可以为nil时，使用weak, 如上面的🌰,将Girl 中的boyFriend 用weak来修饰, 你也可以让 Boy中的girlFriend 用weak来修饰, 都可以解决这个问题


//对于可以为nil的属性, 我们可以通过 weak解决问题, 那不可以为nil的呢?

//可以通过 unowned 来解决






















