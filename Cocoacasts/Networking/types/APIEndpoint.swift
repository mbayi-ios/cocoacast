import Foundation

enum APIEndpoint {
    case episodes
    case auth(email: String, password: String)

    var request: URLRequest {
        var request = URLRequest(url: url)

        request.addHeaders(headers)
        request.httpMethod = httpMethod.rawValue

        return request
    }

    private var url: URL {
        Environment.apiBaseURL.appendingPathComponent(path)
    }

    private var path: String {
        switch self {
        case .auth:
            return "auth"

        case .episodes:
            return "episodes"
        }
    }

    private var headers: Headers {
        var headers: Headers = [
            "Content-Type" : "application/json",
            "X-API-TOKEN" : Environment.apiToken
        ]

        if case let .auth(email:email , password: password) = self {
            let authData = (email + ":" + password).data(using: .utf8)!
            let encodedAuthData = authData.base64EncodedString()
            headers["Authorization"] = "basic \(encodedAuthData)"
        }

        return headers
    }

    private var httpMethod: HTTPMethod {
        switch self {
        case .auth:
            return .post

        case .episodes:
            return .get
        }
    }

}

extension URLRequest {
    mutating func addHeaders(_ headers: Headers) {
        headers.forEach { header, value in
            addValue(value, forHTTPHeaderField: header)
        }
    }
}
