//
//  File.swift
//  ExamenStefaniniOmar
//
//  Created by Omar Diaz on 29/06/23.
//

import Foundation
import UIKit
import CoreData

class DeleteViewModel{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func Add(message : Message) -> Result{
        var result = Result()
        do{
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "MessageDB", in: context)
            let messageDB = NSManagedObject(entity: entidad!, insertInto: context)
            
            messageDB.setValue(message.id, forKey: "id")
            messageDB.setValue(message.emisor, forKey: "emisor")
            messageDB.setValue(message.correoEmisor, forKey: "correoEmisor")
            messageDB.setValue(message.asunto, forKey: "asunto")
            messageDB.setValue(message.mensaje, forKey: "mensaje")
            messageDB.setValue(message.hora, forKey: "hora")
            messageDB.setValue(message.leido, forKey: "leido")
            messageDB.setValue(message.destacado, forKey: "destacado")
            messageDB.setValue(message.spam, forKey: "spam")
            
            try! context.save()
            result.Correct = true
            
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    func GetAll() -> Result {
        var result = Result()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MessageDB")
        do {
            let messages = try context.fetch(request)
            result.Objects = [Message]()
            for objMessage in messages as! [NSManagedObject] {
                var message = Message()
                
                message.id = objMessage.value(forKey: "id") as! Int
                message.emisor = objMessage.value(forKey: "emisor") as! String
                message.correoEmisor = objMessage.value(forKey: "correoEmisor") as! String
                message.asunto = objMessage.value(forKey: "asunto") as! String
                message.mensaje = objMessage.value(forKey: "mensaje") as! String
                message.hora = objMessage.value(forKey: "hora") as! String
                message.leido = objMessage.value(forKey: "leido") as! Bool
                message.destacado = objMessage.value(forKey: "destacado") as! Bool
                message.spam = objMessage.value(forKey: "spam") as! Bool
                
                result.Objects?.append(message)
            }
            result.Correct = true
        } catch let error {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    func getById(id: Int) -> Bool{
        var retbool = false
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"MessageDB")
        let predicado = NSPredicate(format: "id = %@", String(id))
        request.predicate = predicado
        do{
            let context = appDelegate.persistentContainer.viewContext
            let resul = try! context.fetch(request)
            if resul.count > 0 {
                retbool = true
            }else{
                retbool = false
            }
        }
        return retbool
    }
    
    func deleteItem(id: Int) -> Result {
        var result = Result()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MessageDB")
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        do {
            let context = appDelegate.persistentContainer.viewContext
            let resultados = try context.fetch(fetchRequest)
            
            // Verifica si se encontraron elementos
            if resultados.count > 0 {
                // Si se encontraron elementos, elimina el primero de ellos
                let elementoAEliminar = resultados[0] as! NSManagedObject
                context.delete(elementoAEliminar)
                
                // Guarda los cambios en Core Data
                try context.save()
                result.Correct = true
            }
        } catch {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    func Delete(){
        do{
            let context = appDelegate.persistentContainer.viewContext
            let entidad = NSFetchRequest<NSFetchRequestResult>(entityName: "MessageDB")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: entidad)
            
            try context.execute(batchDeleteRequest)
            try context.save()

            print("Eliminado")
        }catch{
            print("No eliminado")
        }
    }
    
}
