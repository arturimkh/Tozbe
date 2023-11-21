//
//  AppDelegate.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 15.11.2023.
//
import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let appCoordinator = AppCoordinator.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        IQKeyboardManager.shared.enable = true
        appCoordinator.start(on: window)

        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light

        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        handleAudioRecordingInBackground()
    }
    private func handleAudioRecordingInBackground() {
        if let navigationController = window?.rootViewController as? UINavigationController,
           let mainViewController = navigationController.viewControllers.last as? MainViewController,
           let audioRecorder = mainViewController.audioRecorder,
           audioRecorder.isRecording {
            mainViewController.stopRecording()
            mainViewController.saveAudioFile(audioRecorder.url)
        }
    }

}
