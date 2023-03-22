//
//  Observable.swift
//  PokeApp
//
//  Created by ertugrul.ozvardar on 20.03.2023.
//

import Foundation

class Observable<T> {
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T?) -> ())?
    
    func bind(_ listener: @escaping(T?) -> ()) {
        listener(value)
        self.listener = listener
    }
}
