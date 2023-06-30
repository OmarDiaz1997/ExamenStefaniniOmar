//
//  Message.swift
//  ExamenStefaniniOmar
//
//  Created by Omar Diaz on 29/06/23.
//

import Foundation

struct Message {
    var id: Int
    var emisor: String
    var correoEmisor: String
    var asunto: String
    var mensaje: String
    var hora: String
    var leido: Bool
    var destacado: Bool
    var spam: Bool
    
    init(id: Int, emisor: String, correoEmisor: String, asunto: String, mensaje: String, hora: String, leido: Bool, destacado: Bool, spam: Bool) {
        self.id = id
        self.emisor = emisor
        self.correoEmisor = correoEmisor
        self.asunto = asunto
        self.mensaje = mensaje
        self.hora = hora
        self.leido = leido
        self.destacado = destacado
        self.spam = spam
    }
    
    init() {
        self.id = 0
        self.emisor = ""
        self.correoEmisor = ""
        self.asunto = ""
        self.mensaje = ""
        self.hora = ""
        self.leido = false
        self.destacado = false
        self.spam = false
    }
    
}
