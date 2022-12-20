# How we accelerate EV3a in verilog code

## Table of content

1. [Hardware structure](#i-hardward-structure)
2. [software vs. hardware](#ii-software-vs-hardware)
3. [Result](#iii-result)
4. [Execuate](#iv-command)

## I. Hardward Structure
<br>

## OverView
<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208288411-3e58a420-acd8-49ae-bb7f-bea1728c5354.png" width="600" heigh ="600"/>
</p>

## LFSR

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208288484-bb7d2b86-4a70-4aba-8949-792c398b9404.png" width="600" heigh ="600"/>
</p>

## Tourment, CrossOver and mutate Data Path

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208344561-ea556732-7c6e-4927-85d9-40430ad9afb8.png" width="1000" heigh ="1000"/>
</p>

## Tourment, CrossOver and mutate Data Path Detail

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208344681-6762b659-7fae-4a37-9a03-55ac4ec84751.png" width="1000" heigh ="1000"/>
</p>


## Evaluate Fitness Data path

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208344472-8d182392-5145-43c7-b699-919556126ab5.png" width="1000" heigh ="1000"/>
</p>

## II. Software vs. Hardware
<br>

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208288629-12a0fadb-1745-417d-9b79-b413c99e030f.png" width="600" heigh ="600"/>
</p>

## III. Result
<br>

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208288751-27ec5f8f-1c60-4759-b517-57d66db884f2.jpg" width="600" heigh ="600"/>

## IV. Command
<br>

```
# Run Ncverilog RTL simulation 
sh 01_run_RTL  
# Run synthesize
sh 03_run_dc
# Run Gate Level simulation
sh 02_run_Gate
# Run Post sim
sh 04_run_POST
# Run clean file
sh 09_clean_up
```
