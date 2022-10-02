//
//  RequestManager.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/18/22.
//

import Foundation

typealias DecodableResponse<T: Decodable> = (Result<T, RequestError>) -> Void

final class RequestManager: NSObject, URLSessionDelegate {

    var baseApi: String = "https://api.spacexdata.com/v5/launches/query"

    var session: URLSession!

    var responseValidator: ResponseValidatorProtocol

    var reponseLog: URLRequestLoggableProtocol?

    typealias Headers = [String: String]
    typealias Body = [String: Any]

    private override init() {
        self.reponseLog = ResponseLog()
        self.responseValidator = LaunchResponseValidator()
        super.init()
        self.session = URLSession(configuration: URLSessionConfiguration.ephemeral,
                                  delegate: self, delegateQueue: OperationQueue.main)
    }

    public init(session: URLSession, validator: ResponseValidatorProtocol) {
        self.session = session
        self.responseValidator = validator
    }

    static let shared = RequestManager()

}

extension RequestManager: RequestManagerProtocol {

    var timeOutInterval: Double {
        return 6
    }

    func performRequestWith<T: Decodable>(httpMethod: HTTPMethod, body: Data?,
                                          completionHandler: @escaping DecodableResponse<T>) {

        let headers = headerBuilder()

        let urlRequest = urlRequestBuilder(header: headers, httpBody: body, httpMethod: httpMethod)

        performURLRequest(urlRequest, completionHandler: completionHandler)
    }

    private func headerBuilder() -> Headers {
        let headers = [
            "Content-Type": "application/json"
        ]
        return headers
    }

    private func urlRequestBuilder(header: Headers, httpBody: Data?, httpMethod: HTTPMethod) -> URLRequest {

        var urlRequest = URLRequest(url: URL(string: baseApi)!,
                                    cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: timeOutInterval)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpBody = httpBody
        urlRequest.httpMethod = httpMethod.rawValue

        return urlRequest
    }

    private func performURLRequest<T: Decodable>(_ request: URLRequest,
                                                 completionHandler: @escaping DecodableResponse<T>) {

        session.dataTask(with: request) { (data, response, error) in
            self.reponseLog?.logResponse(response as? HTTPURLResponse,
                                         data: data,
                                         error: error, HTTPMethod: request.httpMethod)
            if error != nil {
                return completionHandler(.failure(RequestError.connectionError))
            } else {
                let validationResult: (Result<T, RequestError>) = self.responseValidator.validation(
                    response: response as? HTTPURLResponse,
                    data: data)
                return completionHandler(validationResult)
            }
        }.resume()
    }
}
