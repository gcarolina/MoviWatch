//
//  AppDelegate.swift
//  MoviWatch
//
//  Created by Carolina on 1.02.23.
//

import UIKit
import FirebaseCore
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 18, green: 18, blue: 18)
        UINavigationBar.appearance().tintColor = UIColor.init(red: 179, green: 40, blue: 85)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.init(red: 136, green: 136, blue: 136)]
       
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("User granted permission for notifications")
            } else {
                print("User did not grant permission for notifications")
            }
        }
        setNotification()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


private func setNotification() {
    let crimeFilms = FilmsForGenres.shared.pageData[2].items
    guard let randomFilm = crimeFilms.randomElement() else { return }
    let randomFilmTitle = randomFilm.title

    let content = UNMutableNotificationContent()
    content.title = "А ты уже смотрел «\(randomFilmTitle)»?"
    content.body = "Самое время его посмотреть!"
    content.sound = .default

    var dateComponents = DateComponents()
    dateComponents.hour = 20
    dateComponents.minute = 0
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

    let request = UNNotificationRequest(identifier: "daily-reminder", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling notification: \(error.localizedDescription)")
        } else {
            print("Notification scheduled successfully")
        }
    }
}

