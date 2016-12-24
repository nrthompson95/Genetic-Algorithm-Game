//
//  Genome.swift
//  Genetic Algorithm Game
//
//  Created by Nick Thompson on 8/15/16.
//  Copyright © 2016 Nick Thompson. All rights reserved.
//

import Foundation
import GameKit

class Genome {
    /**
     Public Variables
    */
    
    fileprivate let rand = GKRandomDistribution(lowestValue: 0, highestValue: 1);
    /**
     Works like a binary number, [0|1|...|61|62] -> 0 is MSB, 62 is LSB
    */
    fileprivate var geneticCode : [Int]
    
    init(withCode: [Int]) {
        geneticCode = withCode;
    }
    
    /**
     Returns a random genetic sequence.
    */
    init() {
        geneticCode = [Int](repeating: 0, count: 16);
        for i in 0 ..< 16 {
            updateValueAtLocation(i, withValue: rand.nextInt())
        }
    }
    
    func recombine() {
        for i in 0 ..< geneticCode.count {
            if(arc4random_uniform(5) == 0) {
                geneticCode[i] ^= 1
            }
        }
    }
    
    func getGeneticCodeValueAtIndex(_ index: Int) -> Int{
        return geneticCode[index]
    }
    
    func updateValueAtLocation(_ loc: Int, withValue: Int) {
        geneticCode[loc] = withValue
    }
    
    func getNumericalValue() -> Int{
        var value = 0;
        for i in 0 ..< 16 {
            value = value << 1
            value += geneticCode[i];
        }
        return value
    }
    
    func getFitnessScore(_ forTarget: [Int]) -> Int {
        var val = 0;
        for i in 0 ..< 16 {
            val += forTarget[i] ^ geneticCode[i]
        }
        return val
    }
}
