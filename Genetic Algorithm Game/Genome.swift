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
    
    private let rand = GKRandomDistribution(lowestValue: 0, highestValue: 1);
    /**
     Works like a binary number, [0|1|...|7|8] -> 0 is MSB, 8 is LSB
    */
    private var geneticCode : [Int]
    
    init(withCode: [Int]) {
        geneticCode = withCode;
    }
    
    /**
     Returns a random genetic sequence.
    */
    init() {
        geneticCode = [Int](count: 8, repeatedValue: 0);
        for i in 0 ..< 8 {
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
    
    func getGeneticCodeValueAtIndex(index: Int) -> Int{
        return geneticCode[index]
    }
    
    func updateValueAtLocation(loc: Int, withValue: Int) {
        geneticCode[loc] = withValue
    }
    
    func getNumericalValue() -> Int{
        var value = 0;
        for i in 0 ..< 8 {
            value = value << 1
            value += geneticCode[i];
        }
        return value
    }
    
    func getFitnessScore(forTarget: [Int]) -> Int {
        var val = 0;
        for i in 0 ..< 8 {
            val += forTarget[i] ^ geneticCode[i]
        }
        return val
    }
}