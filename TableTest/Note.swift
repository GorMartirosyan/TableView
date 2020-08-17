//
//  Note.swift
//  TableTest
//
//  Created by Gor on 3/22/20.
//  Copyright © 2020 user1. All rights reserved.
//

import UIKit

struct Note: Codable {
    let name: String
    let description: String
    let imageData: Data?
    let date: Date?
    
    lazy var image: UIImage? = {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }()
}
