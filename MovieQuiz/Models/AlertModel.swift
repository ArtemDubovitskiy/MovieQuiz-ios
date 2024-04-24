//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 20.04.2024.
//
import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void
}
