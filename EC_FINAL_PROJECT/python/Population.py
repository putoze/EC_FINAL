#
# Population.py
#
#

import copy
import math
from operator import attrgetter
from Individual import *


class Population:
    """
    Population
    """
    uniprng = None
    crossoverFraction = None
    individualType = None

    def __init__(self, populationSize):
        """
        Population constructor
        """
        f = open(
            'C:/Users/User/EC_FINAL_PROJECT/EC_FINAL_PROJECT/EC_FINAL_PROJECT/verilog/input.txt', 'w')
        self.population = []
        for i in range(populationSize):
            self.population.append(self.__class__.individualType())
            #f.write('//individual mutate\n')
            # Extension of bit string to 8 bits
            f.write(format(self.population[i].mutRate, '08b'))
            f.write('\n')
            #f.write('\n//individual state\n')
            self.population[i].mutRate = self.population[i].mutRate/255
            for ind_state in self.population[i].state:
                # Extension bit string to 2 bits
                f.write(format(ind_state, '02b'))
            f.write('\n')
            f.write(format(-self.population[i].fit, '010b'))
            f.write('\n')
        f.close()

    def __len__(self):
        return len(self.population)

    def __getitem__(self, key):
        return self.population[key]

    def __setitem__(self, key, newValue):
        self.population[key] = newValue

    def copy(self):
        return copy.deepcopy(self)

    def evaluateFitness(self):
        for individual in self.population:
            individual.evaluateFitness()

    def mutate(self):
        for individual in self.population:
            individual.mutate()

    def crossover(self, index1, index2):

        for _ in range(len(self.population)):
            if index1 >= len(self.population):
                index1 = 0
            if index2 >= len(self.population):
                index2 = 0
            rn = self.uniprng.randint(1, 255)/255
            if rn < self.crossoverFraction:
                self[index1].crossover(self[index2])
            index1 += 1
            index2 += 1

        '''
        self.uniprng.shuffle(indexList1)
        self.uniprng.shuffle(indexList2)

        if self.crossoverFraction == 1.0:
            for index1, index2 in zip(indexList1, indexList2):
                self[index1].crossover(self[index2])
        else:
            for index1, index2 in zip(indexList1, indexList2):
                rn = self.uniprng.randint(1, 255)/255
                if rn < self.crossoverFraction:
                    self[index1].crossover(self[index2])
        '''

    def conductTournament(self):
        # binary tournament
        index1 = self.uniprng.randint(0, len(self.population))
        index2 = self.uniprng.randint(0, len(self.population))

        index1_temp = index1
        index2_temp = index2

        if index1 == index2:
            index2 += 1

        # compete
        newPop = []
        for _ in range(len(self.population)):
            if index1 >= len(self.population):
                index1 = 0
            if index2 >= len(self.population):
                index2 = 0
            if self[index1].fit > self[index2].fit:
                newPop.append(copy.deepcopy(self[index1]))
            elif self[index1].fit < self[index2].fit:
                newPop.append(copy.deepcopy(self[index2]))
            else:
                rn = self.uniprng.random()
                if rn > 0.5:
                    newPop.append(copy.deepcopy(self[index1]))
                else:
                    newPop.append(copy.deepcopy(self[index2]))
            index1 += 1
            index2 += 1

        # overwrite old pop with newPop
        self.population = newPop

        return index1_temp, index2_temp

    def combinePops(self, otherPop):
        self.population.extend(otherPop.population)

    def truncateSelect(self, newPopSize):
        # sort by fitness
        self.population.sort(key=attrgetter('fit'), reverse=True)

        # then truncate the bottom
        self.population = self.population[:newPopSize]

    def __str__(self):
        s = ''
        for ind in self:
            s += str(ind) + '\n'
        return s
