import UIKit

protocol eliminarDB: AnyObject{
    func didTapButtonEliminarDB(id: Int)
}

class DeleteCell: UITableViewCell {
    weak var eliminarDB: eliminarDB?
    
    @IBOutlet weak var emisorLabel: UILabel!
    @IBOutlet weak var asuntoLabel: UILabel!
    @IBOutlet weak var mensajeLabel: UILabel!
    
    var id: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func eliminarActionButton(_ sender: Any) {
        eliminarDB?.didTapButtonEliminarDB(id: id)
    }
    
    func configure(id: Int){
        self.id = id
    }
    
}
