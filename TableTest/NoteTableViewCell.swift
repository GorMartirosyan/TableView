//
//  NoteTableViewCell.swift
//  TableTest
//
//  Created by Gor on 3/22/20.
//  Copyright © 2020 user1. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    static let id = "NoteTableViewCell"
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var imgView: UIImageView!

    func setUp(with note: Note) {
        var note = note
        nameLabel.text = note.name
        descriptionLabel.text = note.description
        if let date = note.date {
            dateLabel.isHidden = false
            dateLabel.text = "Date: " + DateFormatter.note.string(from: date)
        } else {
            dateLabel.isHidden = true
        }
        if let image = note.image {
            imgView.isHidden = false
            imgView.image = image
        } else {
            imgView.isHidden = true
        }
    }
}
