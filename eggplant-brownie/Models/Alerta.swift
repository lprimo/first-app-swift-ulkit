//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Luis Fernando.
//

import UIKit

class Alerta {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(_ Titulo: String, _ Mensagem: String) {
        let alerta = UIAlertController(title: Titulo, message: Mensagem, preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alerta.addAction(botao)
        controller.present(alerta, animated: true, completion: nil)
    }
}
