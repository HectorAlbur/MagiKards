//
//  UIViewController+Ext.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 29/10/26.
//

import UIKit

extension UIViewController {
    //Busca si ya hay un loader agregado en el contenedor (navigationController o la vista)
    private var loaderChild: LoaderViewController? {
        let host: UIViewController = navigationController ?? self
        return host.children.first { $0 is LoaderViewController } as? LoaderViewController
    }

    func showLoader() {
        guard loaderChild == nil else { return }

        let host: UIViewController = navigationController ?? self
        let loader = LoaderViewController(nibName: "LoaderViewController", bundle: nil)

        host.addChild(loader)
        loader.view.frame = host.view.bounds
        loader.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loader.view.alpha = 0
        host.view.addSubview(loader.view)
        loader.didMove(toParent: host)
        UIView.animate(withDuration: 0.2) {
            loader.view.alpha = 1
        }
    }

    func hideLoader() {
        guard let loader = loaderChild else { return }

        loader.willMove(toParent: nil)
        UIView.animate(withDuration: 0.2, animations: {
            loader.view.alpha = 0
        }, completion: { _ in
            loader.view.removeFromSuperview()
            loader.removeFromParent()
        })
    }

    //Alerta sencilla para mostrar mensajes al usuario
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alert, animated: true)
    }
}
