//
//  AppDelegate.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/8/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var setBackgroundTime: Date?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        let navigationViewController = UINavigationController()
        let viewController = HomepageViewController()
        window.backgroundColor = .white
        window.rootViewController = navigationViewController
        navigationViewController.viewControllers = [viewController]
        
        window.makeKeyAndVisible()
        self.window = window
        
        getCoreDataDBPath()
        
        return true
    }

    // MARK: - Application Lifecycle Methods
    func applicationWillResignActive(_ application: UIApplication) {
        setBackgroundTime = Date()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if setBackgroundTime != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "H:mm:ss"
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                
                let alertTitle = String(localized: "App in a background from: ")
                let alert = UIAlertController(
                    title: alertTitle,
                    message: dateFormatter.string(from: self.setBackgroundTime!),
                    preferredStyle: .alert)
                let actionOk = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(actionOk)
                self.window?.rootViewController?.present(alert, animated: true)
                self.setBackgroundTime = nil
            }
        }
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "ContactDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getCoreDataDBPath() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        print("!!! Core Data DB Path :: \(path ?? "Not found")")
    }
}

