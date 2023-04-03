//
//  FileManager.swift
//  MovieSearch
//
//  Created by Roman Hural on 03.04.2023.
//

import Foundation
import UIKit

enum PhotoFileManager {
    private static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func getImagePath(image: UIImage?) -> String {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let timestamp = Int(Date().timeIntervalSince1970 * 1000)
        let randomInt = Int.random(in: 0..<1000000)
        let imageName = "\(timestamp)_\(randomInt).png"
        let imageUrl = documentsDirectory.appendingPathComponent(imageName)
        
        try? image?.pngData()?.write(to: imageUrl)
        
        return imageUrl.path
    }
}
