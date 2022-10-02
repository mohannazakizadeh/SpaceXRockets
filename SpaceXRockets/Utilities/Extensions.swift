//
//  Extensions.swift
//  SpaceXRockets
//
//  Created by Mohanna Zakizadeh on 10/2/22.
//

import Foundation
import UIKit

extension UIImage {
//    func getImage(from stringURL: String) async throws -> UIImage? {
//        if let url = URL(string: stringURL) {
//            let (data, response) = try await URLSession.shared.data(from: url)
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//                throw RequestError.connectionError
//            }
//            return UIImage(data: data)
//        }
//        throw RequestError.notFound
//    }
    func getImage(from stringURL: String, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let url = URL(string: stringURL)!

            // Fetch Image Data
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data) ?? UIImage(named: "launch")!
            DispatchQueue.main.async {
                completion(image)
            }

        }
    }
}
