//
//  AppDelegate.swift
//  FastApp
//
//  Created by Henry Bravo on 2/27/18.
//  Copyright © 2018 Henry Bravo. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let webService = WebService()
        let apiURL = URLRequest(url: URL(string: "http://localhost:1111/wp-json/wp/v2/product")!)
        let disposeBag = DisposeBag()

        let listOfProducts = webService.load([Product].self, from: apiURL)
        
        listOfProducts
            .subscribe(onNext: { product in
                print("PRODUCTOS DECODIFICADOS", product)
            })
            .disposed(by: disposeBag)
        
        return true
    }

    
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

