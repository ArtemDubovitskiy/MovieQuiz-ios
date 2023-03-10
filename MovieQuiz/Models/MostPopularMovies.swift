//
//  MostPopularMovies.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 10.03.2023.
//

import Foundation
// Модель данных
// Структуры, дублирующие компановку JSON
struct MostPopularMovies: Codable {
    let errorMessage: String
    let items: [MostPopularMovie]
}

struct MostPopularMovie: Codable {
    let title: String
    let rating: String
    let imageURL: URL
    
    private enum CodingKeys: String, CodingKey {
    case title = "fullTitle"
    case rating = "imDbRating"
    case imageURL = "image"
    }
}
