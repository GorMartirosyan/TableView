//
//  EmojiSaver.swift
//  TableTest
//
//  Created by Gor on 3/19/20.
//  Copyright © 2020 user1. All rights reserved.
//

import Foundation

class EmojiSaver {
    
    private let emojiesURL: URL
    static let shared = EmojiSaver()
    
    init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        emojiesURL = documentsDirectory.appendingPathComponent("emojies").appendingPathExtension("plist")
    }
    
    func readEmojies() -> [Emoji] {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedEmojiesData = try? Data(contentsOf: emojiesURL),
            let decodedEmojies = try? propertyListDecoder.decode(Array<Emoji>.self, from:
                retrievedEmojiesData) {
            return decodedEmojies
        }
        return []
    }
    
    func writeEmojies(_ emojies: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedEmojies = try? propertyListEncoder.encode(emojies)
        try? encodedEmojies?.write(to: emojiesURL, options: .noFileProtection)
    }
}
