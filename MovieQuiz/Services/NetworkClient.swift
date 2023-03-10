//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by Artem Dubovitsky on 10.03.2023.
//

import Foundation
/// Отвечает за загрузку данных по URL - Создаем свой сетевой клиент
struct NetworkClient {
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url) // создаем запрос из url
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Проверяем, пришла ли ошибка / Распаковываем ошибку
            if let error = error {
                handler(.failure(error))
                return // дальше продолжать не имеет смысла, т.к. заканчиваем выполнение этого кода
            }
            
            // Проверяем, что нам пришёл успешный код ответа / Обрабатываем код ответа
            if let response = response as? HTTPURLResponse, // превращаем response в тип HTTPURLResponse
               response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return // дальше продолжать не имеет смысла, т.к. заканчиваем выполнение этого кода
            }
            
            // Возвращаем данные // Обрабатываем успешный ответ
            guard let data = data else { return }
            handler(.success(data))
        }
        
        task.resume()
    }
}
