//
//  LoaderViewController.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 29/10/26.
//

import UIKit
import Lottie

class LoaderViewController: UIViewController {

    @IBOutlet weak var animationContainer: UIView!
    private var animationView: LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setupview() {
        let animation = LottieAnimationView(name: "loader")
        animation.loopMode = .loop
        animation.contentMode = .scaleAspectFit
        animation.translatesAutoresizingMaskIntoConstraints = false
        animationContainer.addSubview(animation)
        
        NSLayoutConstraint.activate([
            animation.topAnchor.constraint(equalTo: animationContainer.topAnchor),
            animation.bottomAnchor.constraint(equalTo: animationContainer.bottomAnchor),
            animation.leadingAnchor.constraint(equalTo: animationContainer.leadingAnchor),
            animation.trailingAnchor.constraint(equalTo: animationContainer.trailingAnchor)
        ])
        animationView = animation
        animationView?.play()
  
    }
    
    deinit {
        animationView?.stop()
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
