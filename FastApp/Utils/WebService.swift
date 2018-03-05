//
//  WebService.swift
//  FastApp
//
//  Created by Fernando Jarilla on 4/3/18.
//  Copyright © 2018 Henry Bravo. All rights reserved.
//

import RxSwift

enum WebServiceError: Error {
    case badStatus(Int, Data)
    case api(Int, String)
}

struct Status: Decodable {
    let code: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case message = "status_message"
    }
}

final internal class WebService {
    
    let session = URLSession(configuration: .default)
    let decoder = JSONDecoder()
    
    
    func load<T: Decodable>(_ type: T.Type, from urlRequest: URLRequest) -> Observable<T> {
        let decoder = self.decoder
        
        return session.rx.data(request: urlRequest)
            .map {try decoder.decode(T.self, from: $0) }
            .catchError { error in
                guard let webServiceError = error as? WebServiceError else {
                    throw error
                }
                guard case let .badStatus(_, data) = webServiceError else {
                    throw error
                }
                guard let status = try? decoder.decode(Status.self, from: data) else {
                    throw error
                }
                throw WebServiceError.api(status.code, status.message)
        }
    }
}

private extension Reactive where Base: URLSession {
    func data(request: URLRequest) -> Observable<Data> {
        return Observable.create { observer in
            let task = self.base.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        fatalError("Unsupported protocol")
                    }
                    if 200 ..< 300 ~= httpResponse.statusCode {
                        if let data = data {
                            observer.onNext(data)
                        }
                        observer.onCompleted()
                    } else {
                        observer.onError(WebServiceError.badStatus(httpResponse.statusCode, data ?? Data()))
                    }
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}





