//
//  ViewController.swift
//  TableTest
//
//  Created by Gor on 3/12/20.
//  Copyright © 2020 user1. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var emojies: [Emoji] = []
    private var notes: [Note] = []

    @IBOutlet var emojiesList: UITableView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiesList.register(UINib(nibName: NoteTableViewCell.id, bundle: nil), forCellReuseIdentifier: NoteTableViewCell.id)
        emojiesList.dataSource = self
        emojiesList.delegate = self
        emojies = EmojiSaver.shared.readEmojies()
        notes = NoteSaver.shared.readNotes()
        emojiesList.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController {
            if let addEmojiVC = navVC.viewControllers.first as? AddEmojiViewController {
                addEmojiVC.delegate = self
            } else if let addNoteVC = navVC.viewControllers.first as? AddNoteViewController {
                addNoteVC.delegate = self
            }
        }
    }
    
    @IBAction private func addAction() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Add Emoji", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "AddEmoji", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Add Note", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "AddNote", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return (emojies.isEmpty ? 0 : 1) + (notes.isEmpty ? 0 : 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !emojies.isEmpty && section == 0 {
            return emojies.count
        } else {
            return notes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !emojies.isEmpty && indexPath.section == 0 {
            return setUpEmojiCell(for: indexPath)
        } else {
            return setUpNoteCell(for: indexPath)
        }
    }
    
    private func setUpEmojiCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = emojiesList.dequeueReusableCell(withIdentifier: EmojiTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? EmojiTableViewCell else {
                                                    return UITableViewCell()
        }
        let emoji = emojies[indexPath.row]
        cell.setUp(with: emoji,
                   needUp: indexPath.row != 0,
                   needDown: indexPath.row < emojies.count - 1)
        cell.selectionStyle = .none
        cell.infoClosure = {
            self.showAlert(with: emoji)
        }
        cell.copyClosure = {
            self.emojies.append(emoji)
            self.emojiesList.reloadData()
        }
        cell.deleteClosure = {
            self.emojies.remove(at: indexPath.row)
            self.emojiesList.reloadData()
        }
        cell.upClosure = {
            self.emojies.swapAt(indexPath.row, indexPath.row - 1)
            self.emojiesList.reloadData()
        }
        cell.downClosure = {
            self.emojies.swapAt(indexPath.row, indexPath.row + 1)
            self.emojiesList.reloadData()
        }
        return cell
    }
    
    private func setUpNoteCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = emojiesList.dequeueReusableCell(withIdentifier: NoteTableViewCell.id,
                                                 for: indexPath) as? NoteTableViewCell else {
                                                    return UITableViewCell()
        }
        let note = notes[indexPath.row]
        cell.setUp(with: note)
        cell.selectionStyle = .none
        return cell
    }
            
    private func showAlert(with emoji: Emoji) {
        let alert = UIAlertController(title: emoji.symbol + " - " + emoji.name,
                                      message: emoji.desc + " (" + emoji.usage + ").", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if !emojies.isEmpty && section == 0 {
            label.text = "Emojies"
        } else {
            label.text = "Notes"
        }
        return label
    }
}

extension ViewController: AddEmojiViewControllerDelegate {
    func emojiSaved(_ emoji: Emoji) {
        emojies.append(emoji)
        emojiesList.reloadData()
        EmojiSaver.shared.writeEmojies(emojies)
    }
}

extension ViewController: AddNoteViewControllerDelegate {
    func noteSaved(_ note: Note) {
        notes.append(note)
        emojiesList.reloadData()
        NoteSaver.shared.writeNotes(notes)
    }
}
