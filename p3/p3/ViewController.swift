//
//  ViewController.swift
//  p3
//
//  Created by Adnan Kidwai on 6/7/19.
//  Copyright © 2019 Adnan Kidwai. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    let reuseIdentifier = "reuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension ViewController {
    func configure() {
        
        title = "p3"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".jpg") {
                pictures.append(item)
            }
        }
    }
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.selectedImage = pictures[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
        detailsVC.title = pictures[indexPath.row]
    }
}

