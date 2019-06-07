//
//  ViewController.swift
//  p1
//
//  Created by Adnan Kidwai on 5/28/19.
//  Copyright © 2019 Adnan Kidwai. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    let identifier = "identifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".jpg") {
                pictures.append(item)
            }
        }
        
        print(pictures.count)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        pictures.sort()
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.selectedImage = pictures[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
        detailsVC.title = pictures[indexPath.row]
    }
}

