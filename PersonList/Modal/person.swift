//
//  person.swift
//  PersonList
//
//  Created by Nam Le on 5/22/20.
//  Copyright © 2020 Nam Le. All rights reserved.
//

import Foundation
import UIKit

struct Person {
    var name: String
    var phone: String
    var avatarImage: UIImage
}

func fakeData() -> [Person]{
    let person1 = Person(name: "Nam", phone: "1234567890", avatarImage: UIImage(named: "1")!)
    let person2 = Person(name: "Nam", phone: "1234567890", avatarImage: UIImage(named: "2")!)
    let person3 = Person(name: "Nam", phone: "1234567890", avatarImage: UIImage(named: "3")!)
    let person4 = Person(name: "Nam", phone: "1234567890", avatarImage: UIImage(named: "4")!)
    
    return [person1, person2, person3, person4]
}
