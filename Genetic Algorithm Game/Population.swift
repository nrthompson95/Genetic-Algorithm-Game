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
    fileprivate var entities : [Genome]
    fileprivate let targetFitness : [Int];
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
        for _ in 0 ..< 16 {
            fitnessArr.append(rand.nextInt());
        }
        self.init(numberOfSpecies: 5, target: fitnessArr);
    }
    
    fileprivate func breedGenome(_ father: Genome, mother: Genome){
        let rand = GKRandomDistribution(lowestValue: 0, highestValue: 1)
        var code = [Int]();
        for i in 0 ..< 16 {
            if(rand.nextBool()) {
                code.append(father.getGeneticCodeValueAtIndex(i))
            }
            else {
                code.append(mother.getGeneticCodeValueAtIndex(i))
            }
        }
        let gen = Genome(withCode: code)
        gen.recombine();
        entities.append(gen);
    }
    
    fileprivate func sortByFitness() {
        entities.sort { (g1, g2) -> Bool in
            if g1.getFitnessScore(targetFitness) >= g2.getFitnessScore(targetFitness) {
                return false
            }
            return true
        }
    }
    
    fileprivate func cull() {
        self.sortByFitness()
        while entities.count > numSpecies {
            entities.removeLast()
        }
    }
    
    fileprivate func getGenomeScores() -> [Int]{
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
    
    func getFitnessBits() -> [Int] {
        return targetFitness
    }
    
    func performLifeCycle() {
        self.sortByFitness()
        var leftToBreed = [Genome](entities.reversed())
        
        while(leftToBreed.count >= 2) {
            let father = leftToBreed.popLast()!
            let mother = leftToBreed.popLast()!
            self.breedGenome(father, mother: mother)
        }
        
        cull();
    }
    
    func getAllGenome() -> [Genome] {
        return entities;
    }
}
