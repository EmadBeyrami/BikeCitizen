//
//  FlowControlViewController.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import UIKit

class FlowControlViewController: UIViewController, Storyboarded {
    
    // Not using weak IBOultet because: https://stackoverflow.com/a/31395938
    @IBOutlet var toProductsButton: UIButton!
    @IBOutlet var changeLanguageButton: UIButton!
    @IBOutlet var noteLabel: UILabel!
    
    weak var coordinator: AppCoordinator?
    
    lazy var changeLanguageAlertController: UIAlertController = {
        
        let alert = UIAlertController(title: "Change Language", message: nil, preferredStyle: .actionSheet)
        
        let englishLangAlert = UIAlertAction(title: SupportedLanguages.english.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            LanguageManager.shared.currentLanguage = .english
            self.coordinator?.userChangedLanguage()
        }
        
        let finnishLangAlert = UIAlertAction(title: SupportedLanguages.finnish.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            LanguageManager.shared.currentLanguage = .finnish
            self.coordinator?.userChangedLanguage()
        }
        
        let germanLangAlert = UIAlertAction(title: SupportedLanguages.german.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            LanguageManager.shared.currentLanguage = .german
            self.coordinator?.userChangedLanguage()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(englishLangAlert)
        alert.addAction(finnishLangAlert)
        alert.addAction(germanLangAlert)
        alert.addAction(cancelAction)
        
        return alert
    }()
    
    override func viewDidLoad() {
        setupView()
    }
    
    func setupView() {
        
        // toProductsButton
        toProductsButton.backgroundColor = .zalandoOrange
        toProductsButton.setTitle(LocalizedStrings.toProducts.value, for: .normal)
        toProductsButton.setTitleColor(.white, for: .normal)
        toProductsButton.addTarget(self, action: #selector(toProducts), for: .touchUpInside)
        
        // changeLanguageButton
        changeLanguageButton.backgroundColor = .white
        changeLanguageButton.setTitle(LocalizedStrings.changeLanguage.value, for: .normal)
        changeLanguageButton.setTitleColor(.zalandoOrange, for: .normal)
        changeLanguageButton.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        
        // noteLabel
        noteLabel.textAlignment = .center
        noteLabel.font = UIFont.boldSystemFont(ofSize: 20)
        noteLabel.numberOfLines = 0
        noteLabel.text = LocalizedStrings.controllFlowNotelabel.value + "\n Translation is copied from google translate :)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // UINavigationController
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // Navigate to products scene
    @objc func toProducts() {
        coordinator?.toProducts()
    }
    
    // Present Change language AlertVC
    @objc func changeLanguage() {
        self.present(changeLanguageAlertController, animated: true, completion: nil)
    }
}
