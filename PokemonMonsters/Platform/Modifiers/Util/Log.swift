//
//  Log.swift
//  PokemonMonsters
//
//  Created by Gonzalo  on 27/8/22.
//

import Foundation

enum LogEvent: String {
    case error = "[❌]"
    case debug = "[ℹ️]"
    case networkError = "[🔴]"
    case networkRequest = "[🔵]"
    case networkResponse = "[🟢]"
}

func print(_ object: Any) {
    #if DEBUG
    Swift.print(object)
    #endif
}

class Log {

    static var dateFormat = "dd/MM/yyyy hh:mm:ss"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    private static var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    class func error(_ object: Any,
                     filename: String = #file,
                     line: Int = #line,
                     funcName: String = #function) {
        if isLoggingEnabled {
            print("LOG \(Date().toString()) \(LogEvent.error.rawValue)" +
                    "[\(sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)")
        }
    }

    class func debug(_ object: Any,
                     filename: String = #file,
                     line: Int = #line,
                     funcName: String = #function) {
        if isLoggingEnabled {
            print("LOG \(Date().toString()) \(LogEvent.debug.rawValue)" +
                    "[\(sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)")
        }
    }

    class func networkRequest(request: URLRequest) {
        if isLoggingEnabled {
            let url = request.url ?? URL(string: "")
            let urlString = url?.absoluteURL.description

            let bodyString = String(decoding: request.httpBody ?? Data(), as: UTF8.self)
            let method = request.httpMethod ?? ""
            let headers = request.allHTTPHeaderFields ?? [:]

            print("\nLOG \(Date().toString()) \(LogEvent.networkRequest.rawValue) -> Request with:\n\tURL: " +
                    "\(urlString ?? "")\n\tMethod: \(method)\n\tHeaders: \(headers )\n\tBody:\(bodyString)\n")
        }
    }

    class func networkError(_ object: Any,
                            filename: String = #file,
                            line: Int = #line,
                            funcName: String = #function) {
        if isLoggingEnabled {
            print("\nLOG \(Date().toString()) \(LogEvent.networkError.rawValue)" +
                    "[\(sourceFileName(filePath: filename))]:\(line) \(funcName) -> \(object)")
        }
    }

    class func networkResponse(response: HTTPURLResponse?, data: Data?) {
        let httpCodes: Range<Int> = 200 ..< 300
        guard let unwrappedResponse = response else {
            print("\nLOG \(Date().toString()) \"Log error")
            return
        }
        if isLoggingEnabled {
            let url = unwrappedResponse.url ?? URL(string: "")
            let urlString = url?.absoluteURL.description
            let headers = unwrappedResponse.allHeaderFields
            let status = unwrappedResponse.statusCode
            var stringResponse = String(decoding: data ?? Data(), as: UTF8.self)

            var logEvent = LogEvent.networkResponse.rawValue

            if !httpCodes.contains(unwrappedResponse.statusCode) {
                logEvent = LogEvent.error.rawValue
            }

            let showResponse: Bool = false
            if !showResponse {
                stringResponse = "Not showing response, due to too many contacts. You can change this at Log.swift"
            }

            print("\nLOG \(Date().toString()) \(logEvent) -> Response with:\n\tURL: \(urlString ?? "")" +
                    "\n\tStatusCode: \(status)\n\tHeaders: \(headers)\n\tResponse: \(stringResponse)\n")
        }
    }

    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
