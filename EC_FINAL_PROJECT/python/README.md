# EV3a 

## Some Suggestion
&emsp;&emsp;Before you start this project.,some background knowledge you must need to know: First,you have to know what "Evalutionary Calculation" is. I strongly suggest you to have the class before starting. Second, some accelerating skills on hardware will be used in this design. For example, pipelining, caching and so on. Wish you have a good time for learning it~~

## Tips for you to implement this design on hardware

1. Change into non-self_adaptive mutate<br />
2. Change all random variable into INT8<br />
3. Write individual into txt file<br />
4. Write Self-energy, interact-energy into txt file<br />
5. Try INT8 precision in python code before designing verilog code<br />
6. If you have done your verilog code, you can use the result of your testbench then putting it into python to check the answer. In my case, my Test.py file is used for testing Evaluate fitness verilog file.

## To Execute Our code
```
python ev3a.py --input ev3a_example.cfg
```

