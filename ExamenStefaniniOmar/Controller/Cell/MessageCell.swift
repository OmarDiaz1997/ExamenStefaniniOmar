//
//  MessageCell.swift
//  ExamenStefaniniOmar
//
//  Created by Omar Diaz on 29/06/23.
//

import UIKit

protocol destacadoDelegate: AnyObject {
    func didTapButtonDestacado(id: Int)
}

protocol eliminarDelegate: AnyObject{
    func didTapButtonEliminar(id: Int)
}

protocol spamDelegate: AnyObject{
    func didTapButtonSpam(id: Int)
}

class MessageCell: UITableViewCell {
    weak var destacadoDelegate: destacadoDelegate?
    weak var eliminarDelegate: eliminarDelegate?
    weak var spamDelegate: spamDelegate?
    
    @IBOutlet weak var destacadoButton: UIButton!
    @IBOutlet weak var spamButton: UIButton!
    @IBOutlet weak var emisorTextField: UILabel!
    @IBOutlet weak var asuntoTextField: UILabel!
    @IBOutlet weak var mensajeTextField: UILabel!
    @IBOutlet weak var horaTextField: UILabel!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var leidoContentView: UIView!
    var id = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func destacadoActionButton(_ sender: Any) {
        destacadoDelegate?.didTapButtonDestacado(id: id)
    }
    
    @IBAction func eliminarActionButton(_ sender: Any) {
        eliminarDelegate?.didTapButtonEliminar(id: id)
    }
    
    @IBAction func spamActionButton(_ sender: Any) {
        spamDelegate?.didTapButtonSpam(id: id)
    }
    
    func configure(id: Int){
        self.id = id
    }

}
