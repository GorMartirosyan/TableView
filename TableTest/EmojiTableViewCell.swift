//
//  EmojiTableViewCell.swift
//  TableTest
//
//  Created by Gor on 3/15/20.
//  Copyright © 2020 user1. All rights reserved.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    static let reuseIdentifier = "EmojiCell"
    
    @IBOutlet private weak var infoButton: UIButton!
    @IBOutlet private weak var copyButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var upButton: UIButton!
    @IBOutlet private weak var downButton: UIButton!

    @IBOutlet private weak var symbolLable: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    var infoClosure: (() -> Void)?
    var copyClosure: (() -> Void)?
    var deleteClosure: (() -> Void)?
    var upClosure: (() -> Void)?
    var downClosure: (() -> Void)?

    func setUp(with emoji: Emoji, needUp: Bool, needDown: Bool) {
        symbolLable.text = emoji.symbol
        nameLabel.text = emoji.name
        descriptionLabel.text = emoji.desc
        upButton.isHidden = !needUp
        downButton.isHidden = !needDown
    }
            
    @IBAction private func infoAction(_ sender: Any) {
        infoClosure?()
    }
    
    @IBAction private func copyAction(_ sender: Any) {
        copyClosure?()
    }
        
    @IBAction private func deleteAction(_ sender: Any) {
        deleteClosure?()
    }
    
    @IBAction private func upAction(_ sender: Any) {
        upClosure?()
    }
        
    @IBAction private func downAction(_ sender: Any) {
        downClosure?()
    }
}
