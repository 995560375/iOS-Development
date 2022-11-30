//
//  TableViewController.swift
//  Quiz
//
//  Created by sunny on 2022/11/25.
//

import UIKit

class TableViewController: UITableViewController {
    
    var itemStore: ItemStore!;
    var imageStore: ImageStore!
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        let newItem = itemStore.createItem();
        
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0);
            tableView.insertRows(at: [indexPath], with: .automatic);
        }
    }
//    @IBAction func toggleEditingMode(_ sender: UIButton) {
//        if isEditing {
//            sender.setTitle("Edit", for: .normal);
//            setEditing(false, animated: true);
//        } else {
//            sender.setTitle("Done", for: .normal);
//            setEditing(true, animated: true);
//        }
//    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 65;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        navigationItem.leftBarButtonItem = editButtonItem;
    }

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableView");
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell;
        let item = itemStore.allItems[indexPath.row];
        
//        cell.textLabel?.text = item.question;
//        cell.detailTextLabel?.text = item.answer;
        
        cell.questionLabel.text = item.question;
        cell.selectionLabel.text = item.selection;
        cell.answerLabel.text = item.answer;

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row];
            itemStore.removeItem(item);
            imageStore.deleteImage(forKey: item.itemKey)
            tableView.deleteRows(at: [indexPath], with: .automatic);
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem":
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row];
                let detailViewController = segue.destination as! DetailViewController;
                detailViewController.item = item;
                detailViewController.imageStore = imageStore
            }
        default:
            preconditionFailure("Unexpected segue identifier");
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
}
