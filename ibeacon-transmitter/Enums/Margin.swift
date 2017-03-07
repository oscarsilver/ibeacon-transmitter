//
//  Margin.swift
//  ibeacon-transmitter
//
//  Created by Oscar Silver on 2017-03-07.
//  Copyright © 2017 Snowlayer. All rights reserved.
//

import Foundation
import Cartography

/* You can use either "M4n" or "Margin" */
typealias M4n = Margin
enum Margin: CGFloat {
    case none = 0
    case m2 = 2
    case m4 = 4
    case m6 = 6
    case m8 = 8
    case m16 = 16
    case m20 = 20
    case m30 = 30
    case m40 = 40
    case m50 = 50
}

func == (lhs: NumericalEquality, rhs: Margin) -> NSLayoutConstraint {
    return lhs == rhs.rawValue
}

func <= (lhs: NumericalInequality, rhs: Margin) -> NSLayoutConstraint {
    return lhs <= rhs.rawValue
}

func >= (lhs: NumericalInequality, rhs: Margin) -> NSLayoutConstraint {
    return lhs >= rhs.rawValue
}

func + <P: Addition>(lhs: P, rhs: Margin) -> Expression<P> {
    return rhs.rawValue + lhs
}

func + <P: Addition>(lhs: Expression<P>, rhs: Margin) -> Expression<P> {
    return rhs.rawValue + lhs
}

func - <P: Addition>(lhs: P, rhs: Margin) -> Expression<P> {
    return rhs.rawValue - lhs
}

func - <P: Addition>(lhs: Expression<P>, rhs: Margin) -> Expression<P> {
    return rhs.rawValue - lhs
}

func * <P: Multiplication>(lhs: Expression<P>, rhs: Margin) -> Expression<P> {
    return rhs.rawValue * lhs
}

func * <P: Multiplication>(lhs: P, rhs: Margin) -> Expression<P> {
    return rhs.rawValue * lhs
}

func / <P: Multiplication>(lhs: Expression<P>, rhs: Margin) -> Expression<P> {
    return lhs * (1 / rhs.rawValue)
}

func / <P: Multiplication>(lhs: P, rhs: Margin) -> Expression<P> {
    return lhs * (1 / rhs.rawValue)
}
