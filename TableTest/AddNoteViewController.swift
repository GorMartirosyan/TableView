//
//  AddNoteViewController.swift
//  TableTest
//
//  Created by Gor on 3/22/20.
//  Copyright © 2020 user1. All rights reserved.
//

import UIKit

protocol AddNoteViewControllerDelegate: class {
    func noteSaved(_ note: Note)
}

private let emptyDateText = "Date: "

class AddNoteViewController: UIViewController {
    
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var descriptionField: UITextField!

    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var datePickerButton: UIButton!
    @IBOutlet private var datePicker: UIDatePicker!
    private var date: Date?
    
    @IBOutlet private var imagePickerButton: UIButton!
    @IBOutlet private var imageView: UIImageView!
    private var imageData: Data?
    
    weak var delegate: AddNoteViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.isHidden = true
        imageView.isHidden = true
        dateLabel.text = emptyDateText
    }
    
    @IBAction private func showDatePickerAction() {
        datePicker.isHidden = !datePicker.isHidden
    }
    
    @IBAction func dateChanged(_ sender: Any) {
        dateLabel.text = emptyDateText + DateFormatter.note.string(from: datePicker.date)
        date = datePicker.date
    }
    
    @IBAction private func cancelAction() {
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBAction private func saveAction() {
        if let delegate = delegate {
            if let name = nameField.text, let description = descriptionField.text {
                let note = Note(name: name, description: description, imageData: imageData, date: date)
                delegate.noteSaved(note)
            }
        }
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBAction private func imagePickerAction() {
        let alert = UIAlertController(title: "Choose Source", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openImagePicker(with: .photoLibrary)
        }))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openImagePicker(with: .camera)
            }))
        }
        present(alert, animated: true)
    }
}

extension AddNoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func openImagePicker(with source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.isHidden = false
            imageView.image = image
            imageData = image.jpegData(compressionQuality: 0.1)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
