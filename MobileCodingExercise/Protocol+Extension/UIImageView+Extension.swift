//
//  UIImageView+Extension.swift
//  MobileCodingExercise
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Load the imageView with a image from web
    ///
    /// - Parameter url: Web URL that contains a imagen
    func loadFrom(url: String) {
        let name = url.replacingOccurrences(of: "/", with: "_")
        
        var filePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        filePath = filePath.appendingPathComponent(name)
        
        self.tag += 1
        let currentTag = self.tag
        
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                let url = URL(fileURLWithPath: filePath.path)
                let data = try Data(contentsOf: url)
                self.image = UIImage(data: data)
            } catch {
                print(error)
            }
            self.unlock(duration: 0.0)
        } else {
            self.image = nil
            self.lock(duration: 0.0)
            APIClient.dataFrom(url: url) { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        try data.write(to: filePath, options: .atomic)
                        if self?.tag == currentTag {
                            self?.image = UIImage(data: data)
                        }
                    } catch {
                        print("Unable to write data: \(error)")
                    }
                    if self?.tag == currentTag {
                        self?.unlock()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.unlock()
                }
            }
        }
    }
}
