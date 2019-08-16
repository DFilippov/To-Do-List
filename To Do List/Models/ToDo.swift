//
//  ToDo.swift
//  To Do List
//
//  Created by Ayu Filippova on 12/08/2019.
//  Copyright © 2019 Dmitry Filippov. All rights reserved.
//

import UIKit

/* в процессе добавили условие, что наш класс унаследован от NSObject
 чтобы использовать из этого класса функцию setValue
 данная функция будет записывать значения в todo
 по аналогии как c Mirrir мы получали ключи и значения,
 но здесь наоборот будем обратно записывать значения
 ТАКЖЕ так как наследуемся от старого класса из обжективСи NSObject,
 для которого всё работает когда объекты связаны динамически (а не статически как у нас в свифте)
 чтобы все свойства класса ToDo стали динамическими перед объявлением класса
 пишем @objcMembers (можно было и перед каждым свойством указать, но так проще)
 в objc когда сеществует некий экземпляр класса, то существует некая таблица,
 в которой он ищет свойства и методы этого класса
 у Swift же все связывается на этапе компиляции (что работает быстрее, но менее гибко)
 
*/
@objcMembers class ToDo: NSObject {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    var image: UIImage?
    
    init(
        title: String = "",
        isComplete: Bool = false,
        dueDate: Date = Date(),
        notes: String? = nil,
        image: UIImage? = nil
    ) {
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
        self.image = image
    }
    
    var capitalizedKeys: [String] {
        return keys.map { $0.capitalizedWithSpaces }
    }
    
    /* создадим переменные для дальнейшего их использования в Mirror
     у Mirror есть вычислимое свойство children ( дает всех его детей, которые
     по сути являются свойствами данного класса ToDo ),
     но нужно children преобразовать из своего формата в массив Строк.
     Это сделаем при помощи функции map или compactMap (compact лучше так как
     он отбрасывает nil'ы (не нужно делать преобразований) и возвращает
     неопциональные значения
     то есть будут ключи - keys и их значения - values
     у keys тип будет String,
     а у values -  Any? (опциональный тк некоторые значения свойств класса
     могут быть опциональными (например notes ,  image)
    */
    var keys: [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    var values: [Any?] {
        return Mirror(reflecting: self).children.map { $0.value }
    }
    
    // оверрайд появляется после того как наследуемся от NSObject (там есть такая функция)
    override func copy() -> Any {
        let newToDo = ToDo(
            title: title,
            isComplete: isComplete,
            dueDate: dueDate,
            notes: notes,
            image: image?.copy() as? UIImage
        )
        
        return newToDo
    }
}
