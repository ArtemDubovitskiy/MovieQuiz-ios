//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 28.02.2023.
//

import Foundation

protocol QuestionFactoryProtocol {
    func requestNextQuestion() -> QuizQuestion?
}
