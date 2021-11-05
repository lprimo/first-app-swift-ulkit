//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Luis Fernando.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {
    
    // MARK: - IBOultlet
    
    @IBOutlet weak var itensTableView: UITableView!
    
    // MARK: - Atributos
    
    var delegate: RefeicoesTableViewController?
    
    var itens: [Item] = []
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet weak var felicidadeTextField: UITextField?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector(self.adicionarItem))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        itens = ItemDao().recupera()
    }
    
    @objc func adicionarItem() {
        let adicionarItemViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItemViewController, animated: true)
    }
    func add(_ item: Item) {
        itens.append(item)
        itensTableView.reloadData()
        ItemDao().save(itens)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        celula.textLabel?.text = itens[indexPath.row].nome
        
        return celula
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        
        if celula.accessoryType == .none {
            celula.accessoryType = .checkmark
            itensSelecionados.append(itens[indexPath.row])
        } else {
            celula.accessoryType = .none
            if let position = itensSelecionados.index(of: itens[indexPath.row]) {
                itensSelecionados.remove(at: position)
            }
        }
        
    }
    
    func recuperaRefeicaoForm() -> Refeicao? {
        guard let nomeDaRefeicao = nomeTextField?.text else {
            return nil
        }
        
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return nil
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        
        return refeicao
    }


    // MARK: - IBActions
    
    @IBAction func adicionar(_ sender: Any) {

        if let refeicao = recuperaRefeicaoForm() {
            delegate?.adicionar(refeicao)
            navigationController?.popViewController(animated: true)
        } else {
            Alerta(controller: self).exibe("Erro", "Ocorreu um errro, tente novamnete mais tarde.")
        }
        
    }
}

