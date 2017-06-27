//
//  NetworkManager.swift
//  Util POC
//
//  Created by Doddabela, Supreeth A (US - Bengaluru) on 5/26/17.
//  Copyright © 2017 Sridhar, Swaroop (US - Bengaluru). All rights reserved.
//

import UIKit
import Foundation


class NetworkManager: NSObject {
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)

    static let sharedNetworkManagerInstance = NetworkManager()
    
    var activeTasks = [Int: Task]()
    
    
    func performDataTaskWithUrl(url : String, completion: @escaping(Any,URLResponse) -> Void){
        
        let task = Task(url: url)
        
        //self.activeTasks[(task.dataTask?.taskIdentifier)!] = task
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        task.dataTask = defaultSession.dataTask(with: URL(string: url)!, completionHandler: {
            (data, response, error) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            task.isProcessing = false
            
            self.activeTasks[(task.dataTask?.taskIdentifier)!] = nil
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                completion(json!,response!)
            }
        })
        task.dataTask?.resume()
        task.isProcessing = true
    }
    
    
    func performDataTaskWithRequest(request : URLRequest, completion: @escaping(Any,URLResponse) -> Void){
        
        let task = Task(url: (request.url?.absoluteString)!)
        //self.activeTasks[(task.dataTask?.taskIdentifier)!] = task
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
        task.dataTask = defaultSession.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            task.isProcessing = false
            
            // self.activeTasks[(task.dataTask?.taskIdentifier)!] = nil
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                completion(json!,response!)
            }
        })
        task.dataTask?.resume()
        task.isProcessing = true
    }

    func performPostDataTaskWithRequest(request : URLRequest , parameters : Dictionary<String, Any>? , completion: @escaping(Any,URLResponse) -> Void){
     
        let task = Task(url: (request.url?.absoluteString)!)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var request = request
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        }
        catch let error{
            print(error.localizedDescription)
        }

        
        task.dataTask = defaultSession.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            task.isProcessing = false
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                completion(json!,response!)
            }
            
        })
        
        task.dataTask?.resume()
        task.isProcessing = true

        
    }

    
}

