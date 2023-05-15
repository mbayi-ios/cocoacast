import Foundation

struct SignInResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
