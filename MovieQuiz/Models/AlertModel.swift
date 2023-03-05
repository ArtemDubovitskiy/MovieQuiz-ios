//
//  File.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 01.03.2023.
//

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    var completion: (() -> Void)
}
