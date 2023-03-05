//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 02.03.2023.
//

import Foundation

protocol StatisticService {
    func store(correct count: Int, total amount: Int)
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
}

// Класс реализующий протокол:
final class StatisticServiceImplementation: StatisticService {
    
    private let userDefaults = UserDefaults.standard
    
    // Ключи всех сущностей
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    // Кол-во правильных ответов:
    private var correct: Int {
        get {
            userDefaults.integer(forKey: Keys.correct.rawValue)
            
        }
        set {
            userDefaults.set(newValue, forKey: Keys.correct.rawValue)
            
        }
    }
    // Кол-во вопросов
    private var total: Int {
        get {
            userDefaults.integer(forKey: Keys.total.rawValue)
            
        }
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
            
        }
    }
    
    private var date = Date()
    
    // Метод сохранения текущего результата игры
    func store(correct count: Int, total amount: Int) {
        let gameRecord = GameRecord(correct: count, total: amount, date: date)
        if bestGame < gameRecord {
            self.bestGame = gameRecord
        }
        correct += count
        total += amount
        gamesCount += 1
    }
    
    // Точность ответов
    var totalAccuracy: Double {
        get {
            return 100 * (Double(correct) / Double(total))
        }
    }
    
    // Количество сыгранных игр
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    // Лучший результат квиза:
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
            let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
}


