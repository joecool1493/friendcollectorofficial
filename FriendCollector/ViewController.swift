//
//  ViewController.swift
//  FriendCollector
//
//  Created by Joey Newfield on 1/9/18.
//  Copyright © 2018 Joey Newfield. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var friends: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
           friends = try context.fetch(Friend.fetchRequest())
            tableView.reloadData()
    }   catch  {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.title
        cell.imageView?.image = UIImage(data: friend.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row]
        performSegue(withIdentifier: "friendSegue", sender: friend)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! FriendViewController
        nextVC.friend = sender as? Friend
    }

}

