# Hardware accelerator for EV3a


&emsp;[Python README Linking ](/EC_FINAL_PROJECT/python/README.md) <br/>
&emsp;[Verilog README Linking](/EC_FINAL_PROJECT/verilog/README.md) 

## I.  Table of content
1. [Introduction](#ii-introduction)
2. [Design Flow Chart](#iii-design-flow-chart)
3. [Hardware Structure](#iv-hardware-structure)
4. [Result](#v-result)
5. [Reference](#vi-reference)

## II. Introduction

&emsp;&emsp;Since EV3a algorithm has already existed. As a result, we would like toimprove it performance by realizing a specific hardware architecture.Common technique in digital design involve pipelining, caching and so on.In this final project, we’ll be using these technique to reduce timecomplexity of EV3a algorithm.

## III. Design-Flow-Chart
### <div align="left"> ASM Chart </div>
<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208284879-3eed16d6-5d95-4759-8b60-6f1494d467db.png" width="250" heigh ="400"/>
</p> <br />

### <div align="left"> POP_RF </div>
<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208285464-37319159-0fa4-459d-90c4-42090a2c6837.png" width="150" heigh ="200"/>
</p>

## IV. Hardware-Structure

### <div align="left"> Block Diagram </div>
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208285568-356b668a-6583-4c13-9589-caa908575a13.png" width="600" heigh ="400"/>
</p>

### <div align="left"> Input-out-interface </div>

### &emsp;a. EV3a Data Config
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208285737-ff09a8d3-96ba-4779-a1f4-c598bc2279cd.png" width="600" heigh ="400"/>
</p>
<br/>

### &emsp;b. Evaluate fitness config
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208285826-1f8a21e4-147e-475b-bfab-04df3e324656.png" width="600" heigh ="400"/>
</p>
<br/>

### &emsp;c. LFSR data config
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208285897-10f0a3ae-b1e6-4508-b8a2-32a260503f09.png" width="600" heigh ="400"/>
</p>
<br/>

## V. Result

### <div align="left"> RTL simulation </div>

### &emsp;a. LFSR 
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208285974-5d88a954-db5e-440d-ac99-feacd0d4fa9e.png" width="400" heigh ="220"/>
</p>

### &emsp;b. Evaluate Fitness
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208361207-7f4551c4-94e6-46bb-b3d9-465ede31a6ed.jpg" width="600" heigh ="460"/>
</p>

### &emsp;c. EV3a
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208286021-8d6d6564-5f29-4700-9105-05533821d30d.jpg" width="800" heigh ="400"/>
</p>
<br/>

### <div align="left"> Synthesize Result </div>

### &emsp;a. Area Report
<p align="justify">
  &emsp;<img src="https://user-images.githubusercontent.com/97605863/208286143-7ed15286-aca4-45ef-ac06-28aebbc31b51.png" width="700" heigh ="400"/>
</p>

### &emsp;b. Timing Report
<p align="justify">
  <img src="https://user-images.githubusercontent.com/97605863/208286155-0191d28b-2b3d-4697-ae12-41cb9b695b13.png" width="500" heigh ="400"/>
</p>

### &emsp;c. Power Report
<p align="justify">
  &emsp;<img src="https://user-images.githubusercontent.com/97605863/208286355-433d4854-dc0d-4c0f-9e9b-126dcd1b3803.png" width="700" heigh ="500"/>
</p>

### <div align="left"> Gate-level simulation </div>

<p align="justify">
  <img src="https://user-images.githubusercontent.com/97605863/208286421-3628a0e2-6cba-4240-ad64-0fd88526feb0.png" width="800" heigh ="400"/>
</p>

<p align="justify">
  <img src="https://user-images.githubusercontent.com/97605863/208286427-3cb14842-eff3-44b4-8188-a1489d14d7fb.png" width="1000" heigh ="800"/>
</p>

### <div align="left"> APR </div>

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/208286437-80808bef-a2d3-4f82-b35c-55a7078371f4.png" width="600" heigh ="600"/>
</p>

## VI. Reference
```
[1] Benjamin Doerr, Frank Neumann. Theory of Evolutionary  Computation. Springer Cham.2020.
[2] G. Andrey and N. Thirer, "A FPGA implementation of hardware  based accelerator for a generic algorithm," 2010 IEEE 26-th Convention of Electricaland   Electronics Engineers in Israel, 2010, pp. 000578-000580,doi: 10.  1109/EEEI.2010.5662152 
[3] MIT 6.375 complex digital system. Arvind, 
>>http://csg.csail.mit.edu/6.375/6_375_2019_www/index.html
[4] Heather Berlin, Zachary Zumbo. Hardware Accelerated Genetic Optimization for PCB Layer Assignment . 
>>http://csg.csail.mit.edu/6.375/6_375_2019_www/handouts/finals/Group_1_report.pdf
[5] ECE 4514 Digital Design II Spring 2008 Lecture 6: A Random  Number Generator. Patrick Schaumont. 
>>https://schaumont.dyn.wpi.edu/schaum/teaching/4514s19/ 
```
