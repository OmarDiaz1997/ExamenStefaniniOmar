import UIKit

class SpamVC: UIViewController {
    @IBOutlet weak var spamTableView: UITableView!
    
    let deleteViewModel = DeleteViewModel()
    var dataLocal: [Message] = []
    var dataFilter: [Message] = []
    var data: [Message] = []
    var model: Message?

    override func viewDidLoad() {
        super.viewDidLoad()
        spamTableView.dataSource = self
        spamTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        dataLocal = EmailViewModel.shared.getArray()
        dataFilter = []
        data = []
        for i in 0...dataLocal.count - 1 {
            let result = validateEliminar(id: dataLocal[i].id)
            if result == false{
                dataFilter.append(dataLocal[i])
            }
        }
        
        for j in 0...dataFilter.count - 1 {
            if dataFilter[j].spam == true{
                data.append(dataFilter[j])
            }
        }
        
        spamTableView.reloadData()
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
    
    func validateSpam(id: Int){
        if let index = dataLocal.firstIndex(where: { $0.id == id }) {
            if EmailViewModel.shared.globalData[index].spam == true {
                EmailViewModel.shared.globalData[index].spam = false
                loadData()
            }
        }
    }
    
    @IBAction func deleteSpamActionButton(_ sender: Any) {
        for i in 0...data.count - 1 {
            if let index = EmailViewModel.shared.globalData.firstIndex(where: { $0.id == data[i].id }) {
                EmailViewModel.shared.globalData.remove(at: index)
            }
        }
        loadData()
    }
    
}

extension SpamVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpamCell
        
        cell.spamDB = self
        cell.configure(id: data[indexPath.row].id)
        cell.emisorLabel.text = " \(data[indexPath.row].emisor)"
        cell.asuntoLabel.text = " \(data[indexPath.row].asunto)"
        cell.mensajeLabel.text = " \(data[indexPath.row].mensaje)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model = data[indexPath.row]
        performSegue(withIdentifier: "spam", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "spam" {
            let send = segue.destination as! DetailsVC
            send.model = self.model
        }
    }
    
}


extension SpamVC: spamDB{
    func didTapButtonSpamDB(id: Int) {
        validateSpam(id: id)
    }
    
}
