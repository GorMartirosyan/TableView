//
//  NoteSaver.swift
//  TableTest
//
//  Created by Gor on 3/22/20.
//  Copyright © 2020 user1. All rights reserved.
//

import Foundation

class NoteSaver {
    
    private let notesURL: URL
    static let shared = NoteSaver()
    
    init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        notesURL = documentsDirectory.appendingPathComponent("notes").appendingPathExtension("json")
    }

    func readNotes() -> [Note] {
        let decoder = JSONDecoder()
        if let retrievedNotesData = try? Data(contentsOf: notesURL),
            let decodedNotes = try? decoder.decode(Array<Note>.self, from:
                retrievedNotesData) {
            return decodedNotes
        }
        return []
    }
    
    func writeNotes(_ notes: [Note]) {
        let encoder = JSONEncoder()
        let encodedNotes = try? encoder.encode(notes)
        try? encodedNotes?.write(to: notesURL, options: .noFileProtection)
    }
}
