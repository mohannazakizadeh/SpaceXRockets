//
//  ResponseValidatorProtocol.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 9/18/22.
//

import Foundation

protocol ResponseValidatorProtocol {
    func validation<T: Decodable>(response: HTTPURLResponse?, data: Data?) -> Result<T, RequestError>
}
