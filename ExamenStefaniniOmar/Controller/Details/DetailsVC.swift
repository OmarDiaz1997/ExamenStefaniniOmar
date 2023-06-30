import UIKit

class DetailsVC: UIViewController {
    @IBOutlet weak var asuntoDetails: UILabel!
    @IBOutlet weak var emisorDetails: UILabel!
    @IBOutlet weak var correoEmisorDetails: UILabel!
    @IBOutlet weak var mensajeDetails: UILabel!
    
    var model: Message?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure(item: model!)
    }
    
    func configure(item: Message){
        asuntoDetails.text = "  \(item.asunto)"
        emisorDetails.text = "  \(item.emisor)"
        correoEmisorDetails.text = "  \(item.correoEmisor)"
        mensajeDetails.text = "\(item.mensaje)"
    }

}
