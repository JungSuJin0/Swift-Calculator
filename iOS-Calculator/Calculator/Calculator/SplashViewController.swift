//
//  SplashViewController.swift
//  Calculator
//
//  Created by 정수진 on 5/19/25.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 필요 시 초기 설정
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        
        lottieAnimationView.play { [weak self] _ in
            self?.moveToMain()
        }
    }
    
    
    func moveToMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainView")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = vc
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
