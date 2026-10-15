//
//  PersonalInfoViewController.swift
//  MagiKards
//
//  Created by Facultad de Contaduría y Administración on 15/10/26.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    private let presenter: PersonalInfoPresenter
    
    init(presenter: PersonalInfoPresenter) {
        self.presenter = presenter
        super.init(nibName: "PersonalInfoViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
