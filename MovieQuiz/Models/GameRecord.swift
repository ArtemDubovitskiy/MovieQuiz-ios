//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 03.03.2023.
//
import Foundation

struct GameRecord: Codable, Comparable {
    let correct: Int
    let total: Int
    let date: Date
    
    static func < (lhs: GameRecord, rhs: GameRecord) -> Bool {
        return lhs.correct < rhs.correct
    }
}
