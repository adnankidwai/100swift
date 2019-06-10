//
//  DetailsViewController.swift
//  p3
//
//  Created by Adnan Kidwai on 6/7/19.
//  Copyright © 2019 Adnan Kidwai. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var selectedImage: String?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}


extension DetailsViewController {
    
    @objc func handleShare() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found 😅")
            return
        }
        let shareSheet = UIActivityViewController(activityItems: [image], applicationActivities: [])
        shareSheet.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(shareSheet, animated: true)
    }
    
    func configure() {
        
        view.backgroundColor = .white
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleShare))
        
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width)
            ])
    }
}

extension DetailsViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
