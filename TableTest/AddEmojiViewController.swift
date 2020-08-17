//
//  AddEmojiViewController.swift
//  TableTest
//
//  Created by Gor on 3/19/20.
//  Copyright © 2020 user1. All rights reserved.
//

import UIKit

protocol AddEmojiViewControllerDelegate: class {
    func emojiSaved(_ emoji: Emoji)
}

class AddEmojiViewController: UIViewController {
    
    @IBOutlet private var sybolField: UITextField!
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var descField: UITextField!
    @IBOutlet private var usageField: UITextField!

    weak var delegate: AddEmojiViewControllerDelegate?
        
    @IBAction private func cancelAction() {
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBAction private func saveAction() {
        if let delegate = delegate {
            if let symbol = sybolField.text, let name = nameField.text, let description = descField.text {
                let emoji = Emoji(symbol: symbol, name: name, desc: description, usage: usageField.text ?? "")
                delegate.emojiSaved(emoji)
            }
        }
        self.navigationController?.dismiss(animated: true)
    }
}
