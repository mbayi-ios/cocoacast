//
//  VideoDurationFormatter.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 18/10/2021.
//

import Foundation

final class VideoDurationFormatter: DateComponentsFormatter {

    // MARK: - Initialization

    override init() {
        super.init()

        unitsStyle = .positional
        allowedUnits = [.minute, .second]
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        unitsStyle = .positional
        allowedUnits = [.minute, .second]
    }

}
