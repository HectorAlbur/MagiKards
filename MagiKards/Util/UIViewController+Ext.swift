//
//  UIViewController+Ext.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 29/10/26.
//

import UIKit

extension UIViewController {
    private var loaderchild: LoaderViewController? {
        children.first { $0 is LoaderViewController } as?
        LoaderViewController
        
    }
    
    func showLoader() {
        guard loaderchild == nil else { return }
        
        let loader = LoaderViewController(nibName: "LoaderviewController", bundle: nil)
        
        addChild(loader)
        loader.view.frame = view.bounds
        loader.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loader.view.alpha = 0
        loader.didMove(toParent: self)
        UIView.animate(withDuration: 0.2) {
            loader.view.alpha = 1
        }
    }
    
    func hideLoader(){
        guard let loader = loaderchild else { return }
        
        loader.willMove(toParent: nil)
        UIView.animate(withDuration: 0.2, animations: {
            loader.view.alpha = 0
        }, completion: { _ in
            loader.view.removeFromSuperview()
            loader.removeFromParent()
            
        })
    }
}
