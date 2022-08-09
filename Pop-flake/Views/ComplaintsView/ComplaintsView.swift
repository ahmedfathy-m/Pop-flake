//
//  ComplaintsView.swift
//  Pop-flake
//
//  Created by Ahmed Fathy on 09/08/2022.
//

import UIKit
import Eureka

class ComplaintsView: FormViewController, ViewControllerProtocol {
    weak var coordinator: AppCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        let label = UILabel()
        label.text = "Complaints"
        label.textColor = .black
        self.navigationItem.titleView = label
        form +++ Section()
                <<< TextRow("Name") { row in
                    row.title = "Name"
                    row.placeholder = "Type in your full name"
                }
                <<< EmailRow("Email") { row in
                    row.title = "Email"
                    row.placeholder = "Type in your email"
                }
                
                <<< TextRow("Issue") { row in
                    row.title = "Complaint"
                    row.placeholder = "What is the issue?"
                }
                
                <<< ButtonRow("Sumbit Row") {row in
                    row.title = "Submit"
                }.onCellSelection({ cell, row in
                    print(self.form.values())
                })
    }
    
}
