//
//  Population.swift
//  Genetic Algorithm Game
//
//  Created by Nick Thompson on 8/15/16.
//  Copyright © 2016 Nick Thompson. All rights reserved.
//

import Foundation
import GameKit

class Population {
    private var entities : [Genome]
    private let targetFitness : [Int];
    let numSpecies : Int;
    
    init(numberOfSpecies: Int, target: [Int]) {
        numSpecies = numberOfSpecies;
        entities = [Genome]()
        for _ in 0 ..< numberOfSpecies {
            entities.append(Genome())
        }
        targetFitness = target
    }
    
    convenience init(target: [Int]) {
        self.init(numberOfSpecies: 5, target: target)
    }
    
    convenience init() {
        let rand = GKRandomDistribution(lowestValue: 0, highestValue: 1)
        var fitnessArr = [Int]()
        for _ in 0 ..< 8 {
            fitnessArr.append(rand.nextInt());
        }
        self.init(numberOfSpecies: 5, target: fitnessArr);
    }
    
    private func breedGenome(father: Genome, mother: Genome) {
        let rand = GKRandomDistribution(lowestValue: 0, highestValue: 1)
        var code = [Int]();
        for i in 0 ..< 8 {
            if(rand.nextBool()) {
                code.append(father.getGeneticCodeValueAtIndex(i))
            }
            else {
                code.append(mother.getGeneticCodeValueAtIndex(i))
            }
        }
        entities.append(Genome(withCode: code));
    }
    
    private func sortByFitness() {
        entities.sortInPlace { (g1, g2) -> Bool in
            if g1.getFitnessScore(targetFitness) >= g2.getFitnessScore(targetFitness) {
                return true
            }
            return false
        }
    }
    
    private func cull() {
        self.sortByFitness()
        while entities.count >= numSpecies {
            entities.removeLast()
        }
    }
    
    private func getGenomeScores() -> [Int]{
        var scores = [Int]();
        for g in entities {
            scores.append(g.getFitnessScore(targetFitness))
        }
        return scores
    }
    
    func getFitnessTarget() -> Int {
        var value = 0;
        for i in 0 ..< targetFitness.count {
            value = value << 1
            value += targetFitness[i];
        }
        return value;
    }
    
    func performLifeCycle() {
        self.sortByFitness()
        var leftToBreed = [Genome](entities.reverse())
        
        while(leftToBreed.count >= 2) {
            let father = leftToBreed.popLast()!
            let mother = leftToBreed.popLast()!
            self.breedGenome(father, mother: mother)
        }
        
        cull();
    }
}
