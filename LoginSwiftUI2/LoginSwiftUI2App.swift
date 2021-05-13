//
//  LoginSwiftUI2App.swift
//  LoginSwiftUI2
//
//  Created by Juan Jose Mendez Rojas on 16/04/21.
//

import SwiftUI
import Firebase

@main
struct LoginSwiftUI2App: App {
    
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//Conexión con Firebase...

class Delegate: NSObject,UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true

    }
}
