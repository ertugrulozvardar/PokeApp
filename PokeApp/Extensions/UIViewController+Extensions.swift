//
//  UIViewController+Extensions.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 21.03.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Loading..", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}
