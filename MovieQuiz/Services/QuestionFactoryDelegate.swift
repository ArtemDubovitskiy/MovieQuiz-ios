//
//  QuestionFactoryDeligate.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 01.03.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
