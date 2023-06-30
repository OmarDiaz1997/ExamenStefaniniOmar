import UIKit

protocol spamDB: AnyObject{
    func didTapButtonSpamDB(id: Int)
}

class SpamCell: UITableViewCell {
    weak var spamDB: spamDB?
    
    @IBOutlet weak var emisorLabel: UILabel!
    @IBOutlet weak var asuntoLabel: UILabel!
    @IBOutlet weak var mensajeLabel: UILabel!
    
    var id = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func spamActionButton(_ sender: Any) {
        spamDB?.didTapButtonSpamDB(id: id)
    }
    
    func configure(id: Int){
        self.id = id
    }
    
}
