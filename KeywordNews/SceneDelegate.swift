//
//  SceneDelegate.swift
//  KeywordNews
//
//  Created by 김동혁 on 2022/07/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let viewModel = KeywordNewsViewModel()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        
        let vc = KeywordNewsViewController()
        vc.bind(viewModel)
        
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
}
