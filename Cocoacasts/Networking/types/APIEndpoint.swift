import Foundation

enum APIEndpoint {
    case episodes

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
        case .episodes:
            return "episodes"
        }
    }

    private var headers: Headers {
        [
            "Content-Type" : "application/json",
            "X-API-TOKEN" : Environment.apiToken
        ]
    }

    private var httpMethod: HTTPMethod {
        switch self {
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
