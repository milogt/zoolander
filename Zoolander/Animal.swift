//
//  Animal.swift
//  Zoolander
//
//  Created by Guo Tian on 1/21/21.
//

import Foundation
import UIKit

class Animal: CustomStringConvertible {
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    var description: String
    
    init(name:String, species:String, age:Int, image:UIImage, soundPath:String) {
        self.name = name
        self.species = species
        self.age = age
        self.image = image
        self.soundPath = soundPath
        self.description = "Animal: name = \(self.name), species = \(self.species), age = \(self.age)"
    }
    
}
