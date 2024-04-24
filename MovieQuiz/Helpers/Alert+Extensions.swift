//
//  Alert+Extensions.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 20.04.2024.
//
import UIKit

struct AlertModels {
    let title: String
    let message: String?
    let actionTitles: [String]
}

protocol AlertView {
    func openAlert(
        title: String,
        message: String?,
        alertStyle: UIAlertController.Style,
        actionTitles: [String],
        actionStyles: [UIAlertAction.Style],
        actions: [((UIAlertAction) -> Void)]
    )
}

extension UIViewController {
    func openAlert(
        title: String,
        message: String?,
        alertStyle: UIAlertController.Style,
        actionTitles: [String],
        actionStyles: [UIAlertAction.Style],
        actions: [((UIAlertAction) -> Void)]) {

        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: alertStyle)

        for(index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(
                title: indexTitle,
                style: actionStyles[index],
                handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}
