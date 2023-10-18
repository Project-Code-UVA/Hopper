import UIKit
import Flutter
import GoogleMaps // Added

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Google Maps!
    GMSServices.provideAPIKey("AIzaSyBfoDZ-MJWx231WVeEq_N4vqi2hYRUTguY")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
