//
//  ViewController.swift
//  Genetic Algorithm Game
//
//  Created by Nick Thompson on 8/15/16.
//  Copyright © 2016 Nick Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var GenerationLabel: UILabel!
    @IBOutlet weak var FitnessTargetLabel: UILabel!
    @IBOutlet weak var GeneticTableView: UITableView!
    @IBOutlet weak var PrototypeGeneticCell: UITableViewCell!
    
    var population = Population() {
        didSet {
            FitnessTargetLabel.text = String(population.getFitnessTarget())
        }
    }
    var generation : Int = 0 {
        didSet {
            GenerationLabel.text = String(generation)
        }
    }
    
    @IBAction func ResetButtonPushed(sender: UIButton) {
        population = Population();
        generation = 0;
    }
    
    @IBAction func AdvanceGeneration(sender: UIButton) {
        generation += 1;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GenerationLabel.text = String(generation);
        FitnessTargetLabel.text = String(population.getFitnessTarget());
        fillTable()
    }
    
    func fillTable() {
        for i in 0 ..< population.numSpecies {
            
        }
    }
}

