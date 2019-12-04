//
//  UIImageView+Cache.swift
//  MarvelTest
//
//  Created by Jesse Tello on 12/1/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation
import  UIKit

extension UIImageView {
    public func loadImage(fromURL url: URL?) {
           guard let imageURL = url else {
               return
           }
           let cache = URLCache.shared
           let request = URLRequest(url: imageURL)
           DispatchQueue.global(qos: .userInitiated).async {
               if let data = cache.cachedResponse(for: request)?.data,
                let image = UIImage(data: data) {
                   DispatchQueue.main.async {
                    self.image = image
                   }
               } else {
                   URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                       if let data = data, let response = response,
                        (response as? HTTPURLResponse)?.statusCode == 200,
                        let image = UIImage(data: data) {
                           let cachedData = CachedURLResponse(response: response, data: data)
                           cache.storeCachedResponse(cachedData, for: request)
                           DispatchQueue.main.async {
                               self.image = image
                           }
                       } else {
                         //Set placeholder image if desired
                       }
                   }).resume()
               }
           }
       }
}
