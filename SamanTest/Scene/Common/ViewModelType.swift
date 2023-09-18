//
//  ViewModelType.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
