//
//  RemoveRefeicaoViewController.swift
//  eggplant-brownie
//
//  Created by Luis Fernando.
//

import UIKit

class RemoveRefeicaoViewController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(closeButton)
        let deleteButton = UIAlertAction(title: "remover", style: .destructive, handler: handler)
        alert.addAction(deleteButton)
        
        controller.present(alert, animated: true, completion: nil)
    }
}
