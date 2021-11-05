//
//  itemDao.swift
//  eggplant-brownie
//
//  Created by Luis Fernando.
//

import UIKit

class ItemDao {
    
    func recuperaDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let caminho = diretorio.appendingPathComponent("itens")
        
        return caminho
    }
    
    func save(_ itens: [Item]) {
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            guard let caminho = recuperaDiretorio() else { return }
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recupera() -> [Item] {
        guard let caminho = recuperaDiretorio() else { return [] }
        do {
            let dados = try Data(contentsOf: caminho)
            guard let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Item> else { return [] }

            return itensSalvos
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
}
