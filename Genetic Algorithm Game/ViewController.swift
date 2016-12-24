//
//  ViewController.swift
//  Genetic Algorithm Game
//
//  Created by Nick Thompson on 8/15/16.
//  Copyright © 2016 Nick Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var GenerationLabel: UILabel!
    @IBOutlet weak var FitnessTargetLabel: UILabel!
    @IBOutlet weak var GeneticTable: UITableView!
    
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
    
    @IBAction func ResetButtonPushed(_ sender: UIButton) {
        population = Population();
        generation = 0;
        self.GeneticTable.reloadData()
    }
    
    @IBAction func AdvanceGeneration(_ sender: UIButton) {
        if(population.getAllGenome()[0].getFitnessScore(population.getFitnessBits()) != 0) {
            generation += 1
            population.performLifeCycle()
            self.GeneticTable.reloadData()
        }
    }
    
    @IBAction func FindAnswer(_ sender: AnyObject) {
        while(population.getAllGenome()[0].getFitnessScore(population.getFitnessBits()) != 0) {
            generation += 1;
            population.performLifeCycle()
        }
        self.GeneticTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GenerationLabel.text = String(generation);
        FitnessTargetLabel.text = String(population.getFitnessTarget());
        
        GeneticTable.delegate = self;
        GeneticTable.dataSource = self;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : GATableViewCell! = tableView.dequeueReusableCell(withIdentifier: "GACell") as! GATableViewCell?
        
        cell.valueTextField.text = String(population.getAllGenome()[indexPath.row].getNumericalValue());
        cell.fitnessTextField.text = String(population.getAllGenome()[indexPath.row].getFitnessScore(population.getFitnessBits()));
        return cell
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return population.getAllGenome().count;
    }
    
    func numberOfSections(in tableView:UITableView) -> Int {
        return 1
    }
}

