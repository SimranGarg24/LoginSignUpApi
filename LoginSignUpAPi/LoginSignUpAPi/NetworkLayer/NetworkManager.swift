//
//  NetworkManager.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 01/05/23.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    var data = SignUpDetails(user: Details(email: "simran@gmail.com", password: "123456"))
    var userData = UserDataModel(firstName: "", lastName: "", age: 0, gender: "")
    var authToken: String?
    private init(){}
    
    func postMethod(type: String, completion: @escaping(Result<[String:Any], APIError>)->Void) {
        var signUpurl = String()
        if type == Key.String.signUp{
            signUpurl = Key.String.baseUrl + Key.String.signUpEndPoint
        }else if type == Key.String.signIn {
            signUpurl = Key.String.baseUrl + Key.String.signInEndPoint
        }
        
        guard let url = URL(string: signUpurl) else{
            print("Error: cannot create URL")
            completion(Result.failure(APIError.badURL))
            return
        }
        
        // Add data to the model
        let signUpData = data
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(signUpData) else{
            print("Error: Trying to convert model to JSON data")
            completion(Result.failure(APIError.parsing))
            return
        }
        
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            guard error == nil else {
                print("Error: error calling POST")
                completion(Result.failure(APIError.url(error as? URLError)))
                return
            }
            
            guard let data = data else {
                print("Error: Did not receive data")
                completion(Result.failure(APIError.parsing))
                return
            }
            
            guard let response = response as? HTTPURLResponse else{
                print("Error: HTTP request failed")
                completion(Result.failure(APIError.unknown))
                return
            }
            
            if !((200..<299) ~= response.statusCode){
                completion(Result.failure(APIError.badResponse(response.statusCode)))
            }
            
            
            self.authToken = response.value(forHTTPHeaderField: "Authorization")
            
            do{
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else{
                    print("Error: HTTP request failed")
                    completion(Result.failure(APIError.badResponse(response.statusCode)))
                    return
                }
                print(jsonObject)
                completion(Result.success(jsonObject))
            }
            catch{
                print("Error: Trying to convert JSON data to string")
                completion(Result.failure(APIError.badResponse(response.statusCode)))
                return
            }
        }.resume()
    }
    
    func putMethod(completion: @escaping(Result<[String:Any], APIError>)->Void) {
        
        let editurl = Key.String.baseUrl + Key.String.editEndPoint
        
        guard let url = URL(string: editurl) else{
            print("Error: cannot create url")
            completion(Result.failure(APIError.badURL))
            return
        }
        let boundary = "Boundary-\(NSUUID().uuidString)"
        let userData = userData
        
        let parameters = [Key.ApiKeys.firstName: userData.firstName,
                          Key.ApiKeys.lastName: userData.lastName,
                          Key.ApiKeys.age: userData.age,
                          Key.ApiKeys.gender: userData.gender
        ] as [String : Any]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let dataBody = createDataBody(withParameters: parameters, userData: userData, boundary: boundary)
        request.httpBody = dataBody
        
        
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            guard error == nil else {
                print("Error: error calling POST")
                completion(Result.failure(APIError.url(error as? URLError)))
                return
            }
            
            guard let data = data else {
                print("Error: Did not receive data")
                completion(Result.failure(APIError.parsing))
                return
            }
            
            guard let response = response as? HTTPURLResponse else{
                print("Error: HTTP request failed")
                completion(Result.failure(APIError.badResponse(404)))
                return
            }
            
            if !((200..<299) ~= response.statusCode){
                completion(Result.failure(APIError.badResponse(response.statusCode)))
            }
            
            do{
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else{
                    print("Error: HTTP request failed")
                    completion(Result.failure(APIError.badResponse(response.statusCode)))
                    return
                }
                completion(Result.success(jsonObject))
            }
            catch{
                print("Error: Trying to convert JSON data to string")
                completion(Result.failure(APIError.parsing))
                return
            }
        }.resume()
    }
    
    func createDataBody(withParameters params: [String: Any]?, userData: UserDataModel, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for(key, value) in parameters{
                body.append("--\(boundary + lineBreak)".data(using: .utf8) ?? Data())
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)".data(using: .utf8) ?? Data())
                
                body.append("\(value) \(lineBreak)".data(using: .utf8) ?? Data())
            }
        }
        
        
        
        if let media = userData.imageUrl {
            body.append("--\(boundary + lineBreak)".data(using: .utf8) ?? Data())
            body.append("Content-Disposition: form-data; name=\"\(Key.ApiKeys.image)\"; filename=\"imagefile.jpeg\"\(lineBreak)".data(using: .utf8) ?? Data())
            body.append("Content-Type: \(media) \"image/jpeg\"\(lineBreak + lineBreak)".data(using: .utf8) ?? Data())
            body.append(media)
            body.append(lineBreak.data(using: .utf8) ?? Data())
        }
        
        body.append("--\(boundary)--\(lineBreak)".data(using: .utf8) ?? Data())
        
        return body
    }
    
    func deleteMethod(completion: @escaping(Result<[String:Any], APIError>)->Void){
        let deleteurl = Key.String.baseUrl + Key.String.signOutEndPoint
        guard let url = URL(string: deleteurl) else{
            print("Error: cannot create URL")
            completion(Result.failure(APIError.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        
        
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            guard error == nil else {
                print("Error: error calling POST")
                completion(Result.failure(APIError.url(error as? URLError)))
                return
            }
            
            guard let data = data else {
                print("Error: Did not receive data")
                completion(Result.failure(APIError.parsing))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<299) ~= response.statusCode else{
                print("Error: HTTP request failed")
                completion(Result.failure(APIError.badResponse(404)))
                return
            }
            
            if !((200..<299) ~= response.statusCode){
                completion(Result.failure(APIError.badResponse(response.statusCode)))
            }
            
            do{
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else{
                    print("Error: HTTP request failed")
                    completion(Result.failure(APIError.parsing))
                    return
                }
                
                completion(Result.success(jsonObject))
                
            }
            catch{
                print("Error: Trying to convert JSON data to string")
                completion(Result.failure(APIError.parsing))
                return
            }
        }.resume()
    }
}
