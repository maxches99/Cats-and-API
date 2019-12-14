//
//  Cat.swift
//  CatsApp
//
//  Created by Максим Чесников on 13.12.2019.
//  Copyright © 2019 Максим Чесников. All rights reserved.
//

import Foundation
import UIKit

class Cat
{
    var id: Int
    var image: UIImage
    
    init(id: Int, image: UIImage) {
        self.id = id
        self.image = image
    }
    func get_id() -> Int
    {
        return self.id
    }
    func get_image() -> UIImage
    {
        return self.image
    }
}
