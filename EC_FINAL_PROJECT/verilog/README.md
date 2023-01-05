# How we accelerate EV3a in verilog code

## Table of content

1. [Hardware structure](#i-hardward-structure)
2. [software vs. hardware](#ii-software-vs-hardware)
3. [Result](#iii-result)

## I. Hardward Structure

## OverView
<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208288411-3e58a420-acd8-49ae-bb7f-bea1728c5354.png" width="600" heigh ="600"/>
</p>

## LFSR

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208288484-bb7d2b86-4a70-4aba-8949-792c398b9404.png" width="600" heigh ="600"/>
</p>

## Evaluate Fitness Data path

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208344472-8d182392-5145-43c7-b699-919556126ab5.png" width="1000" heigh ="1000"/>
</p>

```
for i in range(len(state)):
    # self energy
    totalEnergy += cls.selfEnergy[state[i]]
    # interaction energy
    if i > 0:
        totalEnergy += 2*cls.interactionEnergy[state[i-1]][state[i]]
```

## Tourment, CrossOver and mutate Data Path

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208344561-ea556732-7c6e-4927-85d9-40430ad9afb8.png" width="1000" heigh ="1000"/>
</p>

## Tourment, CrossOver and mutate Data Path Detail

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208344681-6762b659-7fae-4a37-9a03-55ac4ec84751.png" width="1000" heigh ="1000"/>
</p>

### Tourment
```
POP :
for _ in range(len(self.population)):
    if self[index1].fit >= self[index2].fit:
        newPop.append(copy.deepcopy(self[index1]))
    elif self[index1].fit < self[index2].fit:
        newPop.append(copy.deepcopy(self[index2]))
    index1 += 1
    index2 += 1
```

### CrossOver
```
POP :
for _ in range(len(self.population)):
    rn = self.uniprng.randint(1, 255)/255
    if rn < self.crossoverFraction:
        self[index1].crossover(self[index2])
    index1 += 1
    index2 += 1
IND:
for i in range(self.nLength):
    if (self.uniprng.randint(1, 255)/255) < 0.5:
        tmp = self.state[i]
        self.state[i] = other.state[i]
        other.state[i] = tmp
```

### Mutate
```
IND :
for i in range(self.nLength):
    if (self.uniprng.randint(1, 255)/255) < self.mutRate:
        self.state[i] = self.uniprng.randint(0, self.nItems-1)
```

### Truncate

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/210695186-8ad9c719-7f0b-45aa-bf23-c83cee57fe08.jpg" width="600" heigh ="600"/>
</p>

```
def BubbleSort(data):
    n = len(data)
    while n > 1:
        n-=1
        for i in range(n):        
            if data[i] > data[i+1]:  
                data[i], data[i+1] = data[i+1], data[i]
    return data
```


## II. Software vs. Hardware

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208288629-12a0fadb-1745-417d-9b79-b413c99e030f.png" width="600" heigh ="600"/>
</p>

## III. Result

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208288751-27ec5f8f-1c60-4759-b517-57d66db884f2.jpg" width="600" heigh ="600"/>
