//
//  Builder.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 07.06.2024.
//

import UIKit

protocol BuilderProtocol {
    static func getPasscodeController(passcodeState: PasscodeState, sceneDelegate: SceneDelegateProtocol?, isSetting: Bool) -> UIViewController
    static func createTabBarController() -> UIViewController
    
    //vc
    static func createMainScreenController() -> UIViewController
    static func createCameraScreenController() -> UIViewController
    static func createFavouriteScreenController() -> UIViewController
    static func createSettingsViewController() -> UIViewController
    static func createAddPostViewController(photos: [UIImage]) -> UIViewController
    static func createPhotoViewController(image: UIImage?) -> UIViewController
    static func createDetailsController(item: PostItem) -> UIViewController
    
}

class Builder: BuilderProtocol {

    static func getPasscodeController(passcodeState: PasscodeState, sceneDelegate: SceneDelegateProtocol?, isSetting: Bool) -> UIViewController {
        let passcodeView = PasscodeView()
        let keychainManager = KeychainManager()
        let presenter = PasscodePresenter(view: passcodeView, passcodeState: passcodeState, keychainManager: keychainManager, sceneDelegate: sceneDelegate, isSetting: isSetting)
        passcodeView.passcodePresenter = presenter
        return passcodeView
    }
    
    static func createTabBarController() -> UIViewController {
        let tabBarView = TabBarView()
        let presenter = TabBarViewPresenter(view: tabBarView)
        tabBarView.presenter = presenter
        
        return tabBarView
    }
    
    static func createMainScreenController() -> UIViewController {
        let mainView = MainScreenView()
        let presenter = MainScreenPresenter(view: mainView)
        mainView.presenter = presenter
        return mainView
    }
    
    static func createCameraScreenController() -> UIViewController {
        let cameraView = CameraView()
        let cameraService = CameraService()
        let presenter = CameraViewPresenter(view: cameraView, cameraService: cameraService)
       
        cameraView.presenter = presenter
        return UIImagePickerController(rootViewController: cameraView)
    }
    
    static func createFavouriteScreenController() -> UIViewController {
        let favouriteView = FavouriteView()
        let presenter = FavouriteViewPresenter(view: favouriteView)
        favouriteView.presenter = presenter
        return UINavigationController(rootViewController: favouriteView)
    }
    
    static func createDetailsController(item: PostItem) -> UIViewController {
        let detailsView = DetailsView()
        let presenter = DetailsViewPresenter(view: detailsView, item: item)
        detailsView.presenter = presenter
        
        return detailsView
    }
    
    static func createPhotoViewController(image: UIImage?) -> UIViewController {
        let photoView = PhotoView()
        let presenter = PhotoViewPresenter(view: photoView, image: image)
        photoView.presenter = presenter
        
        return photoView
    }
    
    static func createAddPostViewController(photos: [UIImage]) -> UIViewController {
        let addPostView = AddPostView()
        let presenter = AddPostPresenter(view: addPostView, photos: photos)
        
        addPostView.presenter = presenter
        return addPostView
    }
    
    static func createSettingsViewController() -> UIViewController {
        let settingsView = SettingsView()
        let presenter = SettingsViewPresenter(view: settingsView)
        
        settingsView.presenter = presenter
        return UINavigationController(rootViewController: settingsView)
    }
    
}
