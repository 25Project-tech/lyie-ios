//
//  ApiRouter.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {
    
    case loginWithGoogle(loginRequest: BaseRequest)
    case loginWithLyie(loginRequest: BaseRequest)
    case remindPassword(remindPasswordRequest: BaseRequest)
    case registerWithLyie(registerRequest: BaseRequest)
    case getUserDetails(userRequest: BaseRequest)
    case sendActivationEmail(activationRequest: BaseRequest)
    case resetPassword(passwordRequest: BaseRequest)
    case activateLyieUser(activationRequest: BaseRequest)
    case resetPasswordNew(resetPassRequest: BaseRequest)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .loginWithGoogle:
            return .post
        case .loginWithLyie:
            return .post
        case .remindPassword:
            return .post
        case .registerWithLyie:
            return .post
        case .getUserDetails:
            return .post
        case .sendActivationEmail:
            return .post
        case .resetPassword:
            return .post
        case .activateLyieUser:
            return .post
        case .resetPasswordNew:
            return .post
        }
    }
    // MARK: - Parameters
    var parameters: RequestParams {
        switch self {
        case .loginWithGoogle(let loginRequest):
            return.body(["data":loginRequest])
            
        case .loginWithLyie(let loginRequest):
            return.body(["data":loginRequest])
            
        case .remindPassword(let registerRequest):
            return.body(["data":registerRequest])
            
        case .registerWithLyie(let registerRequest):
            return.body(["data":registerRequest])
            
        case .getUserDetails(let registerRequest):
            return.body(["data":registerRequest])
            
        case .sendActivationEmail(let registerRequest):
            return.body(["data":registerRequest])
            
        case .resetPassword(let resetPasswordRequest):
            return.body(["data":resetPasswordRequest])
            
        case .activateLyieUser(let activateRequest):
            return.body(["data":activateRequest])
            
        case .resetPasswordNew(let resetPasswordRequest):
            return.body(["data":resetPasswordRequest])
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .loginWithGoogle:
            return ""
        case .loginWithLyie:
            return ""
        case .remindPassword:
            return ""
        case .registerWithLyie:
            return ""
        case .getUserDetails:
            return ""
        case .sendActivationEmail:
            return ""
        case .resetPassword:
            return ""
        case .activateLyieUser:
            return ""
        case .resetPasswordNew:
            return ""
        }
    }
    
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.formEncode.rawValue, forHTTPHeaderField: HTTPHeaderField.string.rawValue)
        
        // Parameters
        switch parameters {
        
        case .body(let params):
            // first of all convert json to the data
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            do {
                let jsonData = try encoder.encode(params["data"] as! BaseRequest)
                urlRequest.httpBody = jsonData
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    LyieLog.mPrint(jsonString)
                }
            } catch {
                LyieLog.mPrint(error.localizedDescription)
            }
        case .url(let params):
            let queryParams = params.map { pair  in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        return urlRequest
    }
}
