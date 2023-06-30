//
//  ViewController.swift
//  ExamenStefaniniOmar
//
//  Created by Omar Diaz on 29/06/23.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var dataLocal: [Message] = []
    var data: [Message] = []
    var model: Message?
    let deleteViewModel = DeleteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        dataLocal = []
        data = []
        dataLocal = EmailViewModel.shared.getArray()
        for i in 0...dataLocal.count - 1 {
            let result = validateEliminar(id: dataLocal[i].id)
            if result == false{
                data.append(dataLocal[i])
            }
        }
        homeTableView.reloadData()
    }
    
    func loadDestacado(idMessage: Int){
        if let index = EmailViewModel.shared.globalData.firstIndex(where: { $0.id == idMessage }) {
            if EmailViewModel.shared.globalData[index].destacado == true{
                EmailViewModel.shared.globalData[index].destacado = false
                loadData()
            }else{
                EmailViewModel.shared.globalData[index].destacado = true
                loadData()
            }
        }
    }
    
    func loadEliminar(idMessage: Int){
        if let index = data.firstIndex(where: { $0.id == idMessage }) {
            let result = deleteViewModel.Add(message: data[index])
            if result.Correct{
                data.remove(at: index)
                homeTableView.reloadData()
            }else{
                //Error al agregar a la base de datos
                let alert = UIAlertController(title: "Error", message: "Error al agregar a la base de datos", preferredStyle: .alert)
                let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                  })
                alert.addAction(Aceptar)
                self.present(alert,animated: false)
            }
        }
    }
    
    func loadSpam(idMessage: Int){
        if let index = dataLocal.firstIndex(where: { $0.id == idMessage }) {
            if EmailViewModel.shared.globalData[index].spam == false{
                EmailViewModel.shared.globalData[index].spam = true
            }else{
                EmailViewModel.shared.globalData[index].spam = false
            }
        }
        loadData()
    }
    
    func validateEliminar(id: Int) -> Bool{
        var validacion = false
        let result = deleteViewModel.getById(id: id)
        if result{
            validacion = true
        }else{
            validacion = false
        }
        return validacion
    }
    
    func searchMessages(messages: [Message]){
        if messages.isEmpty{
            let alert = UIAlertController(title: "Alerta", message: "No hay datos que coincidan en la busqueda", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: { action in
              })
            alert.addAction(Aceptar)
            self.present(alert,animated: false)
        }else{
            data = messages
            homeTableView.reloadData()
        }
    }

    @IBAction func actionSearchButton(_ sender: Any) {
        guard let searchText = searchTextField.text, searchText != "" else{
            searchTextField.placeholder = "Ingrese una busqueda"
            return
        }
        
        let filteredMessage = data.filter { $0.asunto == searchText }
        searchMessages(messages: filteredMessage)
    }
    
    
    @IBAction func refreshActionButton(_ sender: Any) {
        loadData()
    }
    
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageCell
        
        if data[indexPath.row].leido == false{
            
        }
        
        cell.destacadoDelegate = self
        cell.eliminarDelegate = self
        cell.spamDelegate = self
        
        if data[indexPath.row].destacado == true {
            let image = UIImage(systemName: "star.fill")
            cell.destacadoButton.setImage(image, for: .normal)
            cell.destacadoButton.tintColor = .systemYellow
        }else{
            let image = UIImage(systemName: "star")
            cell.destacadoButton.setImage(image, for: .normal)
            cell.destacadoButton.tintColor = .systemYellow
        }
        
        if data[indexPath.row].spam == true {
            let image = UIImage(systemName: "exclamationmark.triangle.fill")
            cell.spamButton.setImage(image, for: .normal)
            cell.spamButton.tintColor = .systemGray2
        }else{
            let image = UIImage(systemName: "exclamationmark.triangle")
            cell.spamButton.setImage(image, for: .normal)
            cell.spamButton.tintColor = .systemGray6
        }
        
        cell.configure(id: data[indexPath.row].id)
        cell.emisorTextField.text = " \(data[indexPath.row].emisor)"
        cell.asuntoTextField.text = " \(data[indexPath.row].asunto)"
        cell.mensajeTextField.text = " \(data[indexPath.row].mensaje)"
        cell.horaTextField.text = data[indexPath.row].hora
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model = data[indexPath.row]
        performSegue(withIdentifier: "home", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            let send = segue.destination as! DetailsVC
            send.model = self.model
        }
    }
    
}

extension HomeVC: destacadoDelegate{
    func didTapButtonDestacado(id: Int) {
        loadDestacado(idMessage: id)
    }
}

extension HomeVC: eliminarDelegate{
    func didTapButtonEliminar(id: Int) {
        loadEliminar(idMessage: id)
    }
}

extension HomeVC: spamDelegate{
    func didTapButtonSpam(id: Int) {
        loadSpam(idMessage: id)
    }
}
