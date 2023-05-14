import Foundation

enum Environment {

    // MARK: - Cloudinary Base URL

    static var cloudinaryBaseUrl: URL {
        URL(string: "https://res.cloudinary.com/cocoacasts/image/fetch/")!
    }

    static var apiBaseURL: URL {
        URL(string: "https://cocoacasts-mock-api.herokuapp.com/api/v1")!
    }

    static var apiToken: String {
        "1772bb7bc78941e2b51c9c67d17ee76e"
    }

}
