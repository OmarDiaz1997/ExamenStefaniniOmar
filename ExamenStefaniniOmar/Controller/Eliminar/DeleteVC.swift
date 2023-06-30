//
//  DeleteVC.swift
//  ExamenStefaniniOmar
//
//  Created by Omar Diaz on 29/06/23.
//

import UIKit

class DeleteVC: UIViewController {
    @IBOutlet weak var deleteTableView: UITableView!
    
    
    var model: Message?
    let deleteViewModel = DeleteViewModel()
    
    var data: [Message] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteTableView.dataSource = self
        deleteTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

    func loadData(){
        let result = deleteViewModel.GetAll()
        if result.Correct{
            data = result.Objects as! [Message]
            deleteTableView.reloadData()
        }
    }
    
    func eliminarDB(id: Int){
        let result = deleteViewModel.deleteItem(id: id)
        if result.Correct{
            loadData()
        }else{
            let alert = UIAlertController(title: "Error", message: "Error al eliminar el correo", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
              })
            alert.addAction(Aceptar)
            self.present(alert,animated: false)
        }
    }

    @IBAction func eliminarActionButton(_ sender: Any) {
        deleteViewModel.Delete()
        loadData()
    }
    
}

extension DeleteVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeleteCell
        
        cell.eliminarDB = self
        cell.configure(id: data[indexPath.row].id)
        cell.emisorLabel.text = data[indexPath.row].emisor
        cell.asuntoLabel.text = data[indexPath.row].asunto
        cell.mensajeLabel.text = data[indexPath.row].mensaje
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model = data[indexPath.row]
        performSegue(withIdentifier: "delete", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "delete" {
            let send = segue.destination as! DetailsVC
            send.model = self.model
        }
    }
    
}


extension DeleteVC: eliminarDB{
    func didTapButtonEliminarDB(id: Int) {
        eliminarDB(id: id)
    }
}
