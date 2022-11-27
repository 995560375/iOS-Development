//
//  TableViewController.swift
//  Quiz
//
//  Created by sunny on 2022/11/25.
//

import UIKit

class TableViewController: UITableViewController {
    
    var itemStore: ItemStore!;
    @IBAction func addNewItem(_ sender: UIButton) {
        let newItem = itemStore.createItem();
        
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0);
            tableView.insertRows(at: [indexPath], with: .automatic);
        }
    }
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal);
            setEditing(false, animated: true);
        } else {
            sender.setTitle("Done", for: .normal);
            setEditing(true, animated: true);
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableView");
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath);
        let item = itemStore.allItems[indexPath.row];
        
        cell.textLabel?.text = item.question;
        cell.detailTextLabel?.text = item.answer;

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row];
            itemStore.removeItem(item);
            tableView.deleteRows(at: [indexPath], with: .automatic);
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    

    
}
