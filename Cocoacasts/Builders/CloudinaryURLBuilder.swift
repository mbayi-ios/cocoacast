//
//  CloudinaryURLBuilder.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 02/10/2021.
//

import UIKit

final class CloudinaryURLBuilder {

    // MARK: - Properties

    private let source: URL

    // MARK: -

    private var width: Int?
    private var height: Int?

    // MARK: - Initialization

    init(source: URL) {
        // Set URL
        self.source = source
    }

    // MARK: - Public API

    func width(_ width: Int) -> CloudinaryURLBuilder {
        // Update Width
        self.width = width

        return self
    }

    func height(_ height: Int) -> CloudinaryURLBuilder {
        // Update Height
        self.height = height

        return self
    }

    func build() -> URL {
        // Helpers
        var parameters: [String] = []
        var url = Environment.cloudinaryBaseUrl

        if let width = width {
            parameters.append("w_\(width)")
        }

        if let height = height {
            parameters.append("h_\(height)")
        }

        // Define Format
        parameters.append("f_png")

        // Define Device Pixel Ratio
        let dpr = String(format: "%1.1f", UIScreen.main.scale)
        parameters.append("dpr_\(dpr)")

        // Append Parameters
        if !parameters.isEmpty {
            let parametersAsString = parameters.joined(separator: ",")
            url = url.appendingPathComponent(parametersAsString)
        }

        return url.appendingPathComponent(source.absoluteString)
    }

}
