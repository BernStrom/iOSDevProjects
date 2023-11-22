//
//  CacheManager.swift
//  Newscast
//
//  Created by Bern N on 11/23/23.
//

import Foundation


class CacheManager {
    
    static var imageDict = [String : Data]()
    
    static func savedData(_ url: String, _ imageData: Data) {
        // Save the image data along with the image URL
        imageDict[url] = imageData
    }
    
    static func retrievedData(_ url: String) -> Data? {
        return imageDict[url]
    }
    
}
