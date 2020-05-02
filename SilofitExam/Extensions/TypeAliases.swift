//
//  TypeAliases.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import EitherResult

typealias VoidClosure = () -> Void
typealias Callback<T> = (ALResult<T>) -> Void
typealias Closure<T> = (T) -> Void
