//
//  Observable+Ext.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where Element == Bool {
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
    
}

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

extension ObservableType {
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

