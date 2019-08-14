//
//  UserController.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 14/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

enum TypeCountry: String {
    case ae = "Emirados Árabes Unidos"
    case ar = "Argentina"
    case at = "Áustria"
    case bg = "Bulgária"
    case be = "Bélgica"
    case br = "Brasil"
    case ca = "Canadá"
    case ch = "Suiça"
    case cn = "China"
    case co = "Colômbia"
    case cu = "Cuba"
    case cz = "República Checa"
    case de = "Alemanha"
    case eg = "Egito"
    case fr = "França"
    case gb = "Reino Unido"
    case hk = "Hong Kong"
    case it = "Itália"
    case jp = "Japão"
    case kr = "Coréia do Sul"
    case ma = "Marrocos"
    case ng = "Nigéria"
    case nz = "Nova Zelândia"
    case pl = "Polônia"
    case pt = "Portugal"
    case se = "Suécia"
    case ua = "Ucrânia"
    case us = "Estados Unidos"
    case ve = "Venezuela"
    case za = "África do Sul"
}

enum TypeCategory: String {
    case business = "Negócios"
    case entertainment = "Entretenimento"
    case general =  "Geral"
    case health =  "Saúde"
    case science = "Ciência"
    case sports = "Esportes"
    case technology = "Tecnologia"
}

class UserController {
    var arrayCountry: [String] = [TypeCountry.ae.rawValue, TypeCountry.ar.rawValue, TypeCountry.at.rawValue, TypeCountry.bg.rawValue, TypeCountry.be.rawValue, TypeCountry.br.rawValue, TypeCountry.ca.rawValue, TypeCountry.ch.rawValue, TypeCountry.cn.rawValue, TypeCountry.co.rawValue, TypeCountry.cu.rawValue, TypeCountry.cz.rawValue, TypeCountry.de.rawValue, TypeCountry.eg.rawValue, TypeCountry.fr.rawValue, TypeCountry.gb.rawValue, TypeCountry.hk.rawValue, TypeCountry.it.rawValue, TypeCountry.jp.rawValue, TypeCountry.kr.rawValue, TypeCountry.ma.rawValue, TypeCountry.ng.rawValue, TypeCountry.nz.rawValue, TypeCountry.pl.rawValue, TypeCountry.pt.rawValue, TypeCountry.se.rawValue, TypeCountry.ua.rawValue, TypeCountry.ve.rawValue, TypeCountry.za.rawValue]
    
    
    var arrayCategory:[String] = [TypeCategory.business.rawValue, TypeCategory.entertainment.rawValue, TypeCategory.general.rawValue, TypeCategory.health.rawValue, TypeCategory.science.rawValue, TypeCategory.sports.rawValue, TypeCategory.technology.rawValue]
    
    
    func numberOfRowsCountry() -> Int {
        return arrayCountry.count
    }
    
    func loadCountry(index: Int) -> String {
        return arrayCountry[index]
    }
    
    
}
