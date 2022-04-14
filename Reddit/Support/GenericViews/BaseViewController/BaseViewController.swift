//
//  BaseViewController.swift
//  Reddit
//
//  Created by Marcelo Stefano Velasquez Herrera on 13/04/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    var controllerName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Own Methods
    func initBaseView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
