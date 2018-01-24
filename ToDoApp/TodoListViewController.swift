//
//  ViewController.swift
//  ToDoApp
//
//  Created by Minh Vuong on 1/8/18.
//  Copyright © 2018 Minh Vuong. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    var selectedCategory: Category?{ //creating optional variable
        didSet{ //actions to perform WHEN variable is set b/c the var is an optional right now
//            loadItems()
        }
        
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
 
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//        loadItems()

//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
    }

    //TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title //you are populating it at the CURRENT index path
        
        //Ternary Operator ->
        // Value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    //Table View Delegate- allows you to access the ROW that was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // using !xxx means to set it to the OPPOSITE of itself (great for Bool)
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true) //animates and flashes when selecting item.
    }
    // Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField() 
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add Item button on our UIAlert
            
//            let newItem = Item(context: self.context)
//            newItem.title = textField.text!
//            newItem.done = false //setting dafault value of done to false.
//            newItem.parentCategory = self.selectedCategory
//            self.itemArray.append(newItem) //we are force casting it becauase UI Text Field will always be blank
//
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action) //displays the action right below the alert
        
        present(alert,animated: true, completion: nil) //displays the alert, but no action

        
    }
    
    func saveItems(){
        do{
            try context.save()

        }catch{
            print("error saving context\(error)")
        }
        
        self.tableView.reloadData() //refresh table once new item is added
    }
    
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        }else{
//            request.predicate = categoryPredicate
//        }
//
////        let request: NSFetchRequest<Item> = Item.fetchRequest() //No need because of default value above
//        do{
//            itemArray = try context.fetch(request)
//        }catch{
//            print("Error fetching data from context\(error)")
//        }
//    }
}

//extension TodoListViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let requests: NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) //[cd] means case and diatectic insensitive
//
//        requests.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        print("searchBar Pressed")
//
//        loadItems(with: requests, predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0{
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}

