//
//  QuestionFactoryDeligate.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 01.03.2023.
//

import Foundation

protocol QuestionFactoryDelegate { // : AnyObject удалил
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer() // добавлено сообщение об успешной загрузке
    func didFailToLoadData(with error: Error) // добавлено сообщение об ошибке загрузки
}
