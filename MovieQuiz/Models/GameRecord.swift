//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 03.03.2023.
//
import Foundation
// Сохранение данных о рекорде в User Defaults:
struct GameRecord: Codable, Comparable { //
    let correct: Int // кол-во правильных ответов
    let total: Int // кол-во вопросов квиза
    let date: Date // дата завершения раунда
    
    // Метод сравнения рекордов:
    static func < (lhs: GameRecord, rhs: GameRecord) -> Bool {
        return lhs.correct < rhs.correct
    }
}

