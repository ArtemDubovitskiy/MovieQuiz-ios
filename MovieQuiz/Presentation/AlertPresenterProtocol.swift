//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 20.04.2024.
//
import Foundation

protocol AlertPresenterProtocol: AnyObject {
    func showAlert(for model: AlertModel)
}
