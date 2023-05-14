//
//  Environment.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 02/10/2021.
//

import Foundation

enum Environment {

    // MARK: - Cloudinary Base URL

    static var cloudinaryBaseUrl: URL {
        URL(string: "https://res.cloudinary.com/cocoacasts/image/fetch/")!
    }

}
