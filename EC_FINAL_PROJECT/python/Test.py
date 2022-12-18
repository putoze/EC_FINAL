from Evaluator import Particles1D
Particles1D.selfEnergy = [1, 2, 3]
Particles1D.interactionEnergy = [[10, 4, 1], [4, 10, 5], [1, 5, 10]]
f = open("C:/Users/User/EC_FINAL_PROJECT/EC_FINAL_PROJECT/EC_FINAL_PROJECT/verilog/fitness_evaluation/test.txt", "r")
state = []
for i in range(50):
    lines = f.readline()
    lines = lines.strip()
    for line in lines:
        if line != ' ':
            state.append(int(line))
    print(Particles1D.fitnessFunc(state))
    state = []
