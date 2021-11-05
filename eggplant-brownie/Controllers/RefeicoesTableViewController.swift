//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Luis Fernando.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicoesDelegate {

    var refeicoes: [Refeicao] = []
    
    override func viewDidLoad() {
        refeicoes = RefeicaoDao().recupera()
    }

    func adicionar(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
        RefeicaoDao().save(refeicoes)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionarRefeicao" {
            let view = segue.destination as! ViewController
            view.delegate = self
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let linha = indexPath.row

        let refeicao = refeicoes[linha]

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = refeicao.nome

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    @objc func mostrarDetalhes(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else { return }
            let refeicao = refeicoes[indexPath.row]
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicao, handler: {
                alerta in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
        
    }
}
