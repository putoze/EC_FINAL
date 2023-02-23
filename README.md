# Hardware accelerator for EV3a


&emsp;&emsp;[Python README Linking ](/EC_FINAL_PROJECT/python/README.md) <br/>
&emsp;&emsp;[Verilog README Linking](/EC_FINAL_PROJECT/verilog/README.md) 

## I.  Table of content
1. [Introduction](#ii-introduction)
2. [Design Flow Chart](#iii-design-flow-chart)
3. [Hardware Structure](#iv-hardware-structure)
4. [Result](#v-result)
5. [Reference](#vi-reference)
6. [ACKNOWLEDGMENT](#vii-acknowledgment)

## II. Introduction

&emsp;&emsp;Since EV3a algorithm has already existed. As a result, we would like toimprove it performance by realizing a specific hardware architecture.Common technique in digital design involve pipelining, caching and so on.In this final project, we’ll be using these technique to reduce timecomplexity of EV3a algorithm.

<div style="page-break-after: always;"></div>

## III. Design-Flow-Chart


<div align="center">

 |ASM Chart                |  POP_RF|
:-------------------------:|:-------------------------:
  <img src="https://user-images.githubusercontent.com/97605863/208602039-e02016c9-8077-4ea6-abbc-8d8c11aa9106.png" width="200" heigh ="400" />  |  <img src="https://user-images.githubusercontent.com/97605863/208285464-37319159-0fa4-459d-90c4-42090a2c6837.png" width="150" heigh ="200"/>

</div>

<div style="page-break-after: always;"></div>

## IV. Hardware-Structure 

## <div align="left"> Block Diagram </div> 
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208285568-356b668a-6583-4c13-9589-caa908575a13.png" width="600" heigh ="400"/>
</p>

## <div align="left"> Input-out-interface </div>

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

## <div align="left"> RTL simulation </div>

### &emsp;a. LFSR 
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208285974-5d88a954-db5e-440d-ac99-feacd0d4fa9e.png" width="400" heigh ="220"/>
</p>

### &emsp;b. Evaluate Fitness
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208362100-4f9b2fd7-d29c-4ab5-83b7-f110712b8605.jpg" width="600" heigh ="460"/>
</p>

### &emsp;c. EV3a
<p align="left">
  <img src="https://user-images.githubusercontent.com/97605863/208286021-8d6d6564-5f29-4700-9105-05533821d30d.jpg" width="800" heigh ="400"/>
</p>
<br/>

## <div align="left"> Synthesize Result </div>

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

## <div align="left"> Gate-level simulation </div>

<p align="justify">
  <img src="https://user-images.githubusercontent.com/97605863/208286421-3628a0e2-6cba-4240-ad64-0fd88526feb0.png" width="800" heigh ="400"/>
</p>

<p align="justify">
  <img src="https://user-images.githubusercontent.com/97605863/208286427-3cb14842-eff3-44b4-8188-a1489d14d7fb.png" width="900" heigh ="800"/>
</p>

## <div align="left"> SW v.s HW </div>

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/209502501-0df5271d-2e26-4f00-9ebe-5d0423abc0d1.png" width="600" heigh ="600"/>
</p>

## <div align="left"> Table of result </div>

<p align="center">
  <img src="https://user-images.githubusercontent.com/97605863/209506691-61f18ca0-e7d5-485b-ad99-49fd41531abc.png" width="600" heigh ="600"/>
</p>

## VI. Reference

```
[1] Benjamin Doerr, Frank Neumann. Theory of Evolutionary  Computation. Springer Cham.2020.
[2] G. Andrey and N. Thirer, "A FPGA implementation of hardware  based accelerator for a generic algorithm," 2010 IEEE 26-th Convention of Electricaland   Electronics Engineers in Israel, 2010, pp. 000578-000580,doi: 10.  1109/EEEI.2010.5662152 
[3] MIT 6.375 complex digital system. Arvind, 
>> http://csg.csail.mit.edu/6.375/6_375_2019_www/index.html
[4] Heather Berlin, Zachary Zumbo. Hardware Accelerated Genetic Optimization for PCB Layer Assignment . 
>> http://csg.csail.mit.edu/6.375/6_375_2019_www/handouts/finals/Group_1_report.pdf
[5] ECE 4514 Digital Design II Spring 2008 Lecture 6: A Random  Number Generator. Patrick Schaumont. 
>> https://schaumont.dyn.wpi.edu/schaum/teaching/4514s19/ 
```

## VII. ACKNOWLEDGMENT

&emsp;&emsp;We would like to ackowledge Professor Lindor for his mentorship and guidance throughout the research, design and implementation of this project. Without him, there would be no final implementation of this project, so as my EC Teammate. You can fellow their github. Here is the superconnection of their github. Thanks~ <br>
&emsp;&emsp;sicajc : https://github.com/sicajc <br>
&emsp;&emsp;Alchemist-Kang : https://github.com/Alchemist-Kang <br>