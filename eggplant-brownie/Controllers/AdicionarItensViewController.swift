//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by MAC on 29/10/21.
//

import UIKit

protocol AdicionaItensDelegate {
    func add(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextField: UITextField!
    
    // MARK: - Atributos
    var delegate: AdicionaItensDelegate?
    
    
    init(delegate: AdicionaItensDelegate) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    
    @IBAction func adicionarItem(_ sender: Any) {
        // navegar para proxima tela: navigationController.push()
        // navegar para tela anterior: navigationController.pop()
        
        if let nomeItem = nomeTextField.text, let caloriasItem = caloriasTextField.text {
            if let calorias = Double(caloriasItem) {
                let item = Item(nome: nomeItem, calorias: calorias)
                delegate?.add(item)
            }

        }
                
        navigationController?.popViewController(animated: true)
    }
    

}
