# DigitalSystems_Intro
This is the first project of the Digital System course at the university under the supervision of [Dr. Zainalabedin Navabi Shirazi](https://ece.ut.ac.ir/en/~navabi) and it provides an introduction to SystemVerilog HDL(Hardware Description Language).
# Parts of project
You can see the [CA & Report](https://github.com/mahdimoeini8102/DigitalSystems_Intro/tree/main/CA%20%26%20Report) folder which includes a description of the project and the report in which I wrote and the [Codes](https://github.com/mahdimoeini8102/DigitalSystems_Intro/tree/main/Codes) folder which includes all my codes in SystemVerilog HDL.
# Detail
This project provides a glance at basic switch and gate structures and their delays. There are 3 types of delay that were considered in the project:
1. To 1 delay: It's the delay between applying an input signal so that the output becomes logical 1.
2. To 0 delay: It's the delay between applying an input signal so that the output becomes logical 0.
3. To Z delay: It's the delay between applying an input signal so that the output becomes High Impedance.

Some gate's outputs never become High Impedance. So, for such gates, we have just To 1 and To 0 delays. In the whole of the project, these delays have been reported as an ordered triple (or ordered pair for gates their output cannot be Z) and a sharp sign before it. For example #(7,8,9) means To 1 Dealy = 7, To 0 Dealy = 8, and To Z Dealy = 9. The time unit has been defined in the first line of each code.
Some schematics for gates that have been described in the project are as follow:

<img src="/Images/NAND.png" height="300"/>
<img src="/Images/TriStateBuffer.png" height="300"/>
<img src="/Images/MUX.png" height="300"/>
<img src="/Images/MUX2.png" height="300"/>
