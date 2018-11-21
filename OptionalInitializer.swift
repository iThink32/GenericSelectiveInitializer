//
//  OptionalInitializer.swift
//  TestOptionalInitializer
//
//  Created by N.A Shashank on 21/11/18.
//

import Foundation

class GenericSelectiveInitializer {
    
    var a:Int?
    var b:Bool?

    
    func initializeWith<T>(keypath:ReferenceWritableKeyPath<GenericSelectiveInitializer,T>,value:T) {
        self[keyPath:keypath] = value
    }
    
    func valueFrom<ReturnType,Type>(keyPath:KeyPath<GenericSelectiveInitializer,Type>,defaultValue:ReturnType) -> ReturnType {
        let value = self[keyPath:keyPath]
        let mirror = Mirror(reflecting: value)
        guard mirror.displayStyle == Mirror.DisplayStyle.optional,mirror.children.count == 1,let child = mirror.children.first?.value as? ReturnType else{
            return defaultValue
        }
        return child
    }
    
}
