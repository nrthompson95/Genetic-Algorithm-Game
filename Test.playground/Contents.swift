let targetFitness = [0, 0, 1, 1, 1, 0, 0, 1]

func getFitnessTarget() -> Int {
    var value = 0;
    for i in 0 ..< targetFitness.count {
        value = value << 1
        value += targetFitness[i];
    }
    return value;
}

getFitnessTarget()