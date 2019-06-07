//
//  ViewController.swift
//  p2
//
//  Created by Adnan Kidwai on 6/6/19.
//  Copyright © 2019 Adnan Kidwai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var correctAnswer = 0
    var timesQuestionAsked = 0
    
    // Create 3 different flag buttons
    
    let flagButton1: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.tag = 0
        return button
    }()
    
    let flagButton2: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.tag = 1
        return button
    }()
    
    let flagButton3: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.tag = 2
        return button
    }()
    
    // score label from challenge, but will be placed below navcontroller.
    
    let currentScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    
    //MARK: viewDidLoad Method 🔥
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViews()
        makeButtonsDoStuff()
        askQuestion()
        setupScoreLabel()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        var countries = CountriesList()
        countries.countryArray.shuffle()
        flagButton1.setImage(UIImage(named: countries.countryArray[0]), for: .normal)
        flagButton2.setImage(UIImage(named: countries.countryArray[1]), for: .normal)
        flagButton3.setImage(UIImage(named: countries.countryArray[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries.countryArray[correctAnswer].uppercased()
    }
    
    @objc func handleTapped(sender: UIButton!) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct 🎉"
            score += 1
            updateScoreLabel()
        } else {
            title = "Nope 😑"
            score -= 1
            updateScoreLabel()
        }
        
        let ac = UIAlertController(title: title, message: "You're score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    func updateScoreLabel() {
        currentScoreLabel.text = "Score: \(score)"
    }
    
    fileprivate func setupScoreLabel() {
        view.addSubview(currentScoreLabel)
        currentScoreLabel.text = "Score: \(score)"
        currentScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        currentScoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        currentScoreLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        currentScoreLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        currentScoreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 250).isActive = true
    }
    
    
}

// Configure a stack view containing all three buttons

extension ViewController {
    func configureViews() {
        
        let stackView = UIStackView(arrangedSubviews: [flagButton1, flagButton2, flagButton3])
        
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.heightAnchor.constraint(equalToConstant: 360),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
}

extension ViewController {
    func makeButtonsDoStuff() {
        flagButton1.addTarget(self, action: #selector(handleTapped), for: .touchUpInside)
        flagButton2.addTarget(self, action: #selector(handleTapped), for: .touchUpInside)
        flagButton3.addTarget(self, action: #selector(handleTapped), for: .touchUpInside)
    }
}
