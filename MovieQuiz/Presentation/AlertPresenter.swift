//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 20.04.2024.
//
import UIKit

final class AlertPresenter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
    
extension AlertPresenter: AlertPresenterProtocol {
    func showAlert(for model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }
        
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
}
