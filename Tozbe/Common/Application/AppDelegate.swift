//
//  AppDelegate.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//
//import UIKit
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//    var mainViewController: MainViewController?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        let userManager = UserManager()
//        let viewModel = MainViewModel(userManager: userManager) // Assuming you have a MainViewModel
//        mainViewController = MainViewController(viewModel: viewModel)
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = mainViewController
//        window?.makeKeyAndVisible()
//
//        return true
//    }
//
//    func applicationWillResignActive(_ application: UIApplication) {
//        handleAudioRecordingInBackground()
//    }
//
//    private func handleAudioRecordingInBackground() {
//        if let audioRecorder = mainViewController?.audioRecorder, audioRecorder.isRecording {
//            mainViewController?.stopRecording()
//            mainViewController?.saveAudioFile(audioRecorder.url)
//        }
//    }
//}

import UIKit
import IQKeyboardManagerSwift
@main
final class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
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

