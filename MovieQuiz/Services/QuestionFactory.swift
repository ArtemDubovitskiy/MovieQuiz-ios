//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 27.02.2023.
//

import Foundation

final class QuestionFactory: QuestionFactoryProtocol {
    private let moviesLoader: MoviesLoading
    private var delegate: QuestionFactoryDelegate?
    
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
    private var movies: [MostPopularMovie] = []
    
    func loadData() {
        moviesLoader.loadMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let mostPopularMovies):
                    self.movies = mostPopularMovies.items // сохраняем фильм в нашу новую переменную
                    self.delegate?.didLoadDataFromServer() // сообщаем, что данные загрузились
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error) // сообщаем об ошибке нашему MovieQuizViewController
                }
            }
        }
    }

    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in // запуск кода в другом потоке
            guard let self = self else { return }
            let index = (0..<self.movies.count).randomElement() ?? 0 // выбираем произвольный элемент из массива
            
            guard let movie = self.movies[safe: index] else { return }
            
            var imageData = Data() // по умолчанию пустые данные
            
            do {
                imageData = try Data(contentsOf: movie.resizedImageURL) // создание данных из URL
            } catch {
                print("Failed to load image") // отображение ошибки при создании данных
            }
            
            let rating = Float(movie.rating) ?? 0 // превращаем строку в число
            
            let text = "Рейтинг этого фильма больше чем 7?" // стандартный вопрос (подумать как сделать рейтинг = JSON)
            let correctAnswer = rating > 7
            
            let question = QuizQuestion(image: imageData,
                                        text: text,
                                        correctAnswer: correctAnswer)
            
            DispatchQueue.main.async { [weak self] in // возвращение в главный поток после загрузки данных
                guard let self = self else { return }
                self.delegate?.didReceiveNextQuestion(question: question)
            }
        }
    }
}

//    private let questions: [QuizQuestion] = [
//        QuizQuestion(
//            image: "The Godfather",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "The Dark Knight",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "Kill Bill",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "The Avengers",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "Deadpool",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "The Green Knight",
//            correctAnswer: true),
//        QuizQuestion(
//            image: "Old",
//            correctAnswer: false),
//        QuizQuestion(
//            image: "The Ice Age Adventures of Buck Wild",
//            correctAnswer: false),
//        QuizQuestion(
//            image: "Tesla",
//            correctAnswer: false),
//        QuizQuestion(
//            image: "Vivarium",
//            correctAnswer: false)
//    ]
    
//    weak private var delegate: QuestionFactoryDelegate?
//
//    init(delegate: QuestionFactoryDelegate) {
//        self.delegate = delegate
//    }
// Версия для МОК данных:
//    func requestNextQuestion() {
//        guard let index = (0..<questions.count).randomElement() else {
//            delegate?.didReceiveNextQuestion(question: nil)
//            return
//        }
//
//        let question = questions[safe: index]
//        delegate?.didReceiveNextQuestion(question: question)
//    }
