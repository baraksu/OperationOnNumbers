# Operation On Numbers | Assembly Project by Eitan Abraham
**Project Name**:  Operation On Numbers\
**Programmer**: Eitan Abraham\
**Teacher**: Barak Suberri\
**Grade**: 10b\
**School**: Yeshivat Bnei Akiva - Givat Shmuel\
**Year**: 2023
## Table of contentc
* [What does the program do?](#what-does-the-program-do?)
# What does the program do?
The program has a menu then it asks to do 1 of 5 functions:
### 1.
The program gets numbers for the array from the user.
The program gets a number from the user. \
Then asks the user to enter numbers the amount he entered (the program supports numbers from 0 to 65535).
### 2.
The program prints the lowest number in the array.
### 3.
The program prints the highest number in the array.
### 4.
The program prints the average of the numbers in the array.
### 5.
The program ends.
# Running examples
Running examples for the input of 3 numbers 123,456,789.

### 1.

![image](https://github.com/baraksu/OperationOnNumbers/assets/125208277/be0da28f-ae00-4e79-89bd-929a3a5d7da7)

This is an example of setting the array.

### 2.

![image](https://github.com/baraksu/OperationOnNumbers/assets/125208277/e6981186-0d37-44b8-9435-14d91a246d92)

This is an example of finding the lowest number.

### 3.

![image](https://github.com/baraksu/OperationOnNumbers/assets/125208277/7a0e4f0d-cb89-4f9d-a507-da5fe5fa6480)

This is an example of finding the highest number.

### 4.

![image](https://github.com/baraksu/OperationOnNumbers/assets/125208277/8a846bb5-10ac-4df8-8d81-7ceb11c85351)

This is an example of finding the average of the numbers in the array.

### 5.

![image](https://github.com/baraksu/OperationOnNumbers/assets/125208277/314a86c7-02fc-4b8d-be38-827643dbfd52)

This is an example of ending the program.

# Developing Process
Developing this project was extremely tedious and hard but it was very rewarding at the end.

Planning the project was not that hard but the execution of the plan was hard.\
to make life easier I split the code into different parts, procedures.

#### Procedures in the project
* `Menu` - The menu of the project.
* `HighestNum` - Prints the highest number in the array.
* `LowestNum` - Prints the lowest number in the array.
* `GetArrAvg` - Prints the average of the numbers in the array.
* `SetArray` - A procedure to set the array.
* `ScanNum` - A procedure that gets a number up to 65535 and stores it in cx.
* `print_ax` - A procedure that prints the hexadecimal value in ax in decimal form.
 
I planned how the general code of each procedure should be yet still because assembly is the worst coding language in the world I still had problems.
## Input
I will explain more about the most difficult part of this program, the input, and the part about it of\
my journey with it.\
\
The most difficult part of this program, and also the part which took the most time was getting the input for the array.\
To get a number I first thought to myself "Why not just do the program work only on numbers 0-9" but I quickly realized \
how lame that would be, so I started writing a code that gets each char of the number 0-9 in its place in the array, \
and then I would take the chars and add them -30h to a new array that stores the value of the numbers, but that quickly,
turned out not to work well, so I tried thinking of a different way to get the numbers and display them.\
\
after some time I stumbled upon two example files in the emu8086 files.\
and they saved my life, the first one is called ToBin.asm which is supposed to get a number from -32k to 65k and turns it\
to the binary code, so I took the part that gets the input from the user and I messed a bit around with it till it\
fitted my program well, I did the same for the second file print_AX.asm which as the name suggests, prints ax, from\
hexadecimal to decimal.\
\
The way the ScanNum procedure works (The procedure that gets a number from the user) is by getting a number and then doing\
multiple checks. The first check is to check if you pressed enter and if you did then you exit the procedure with the\
input number in its true value in hexadecimal stored in the register cx. The second check checks if you pressed
backspace and if you did then it removes the last digit both from the screen and from the cx, the place the number is \
stored, if you didn't then the code moves to store the number the way it stores the number is by multiplying the last \
number by 10, so it would be 123 and not 6, then it adds the new number.\
\
The print_ax procedure prints the hexadecimal value stored in ax in decimal form, the way this procedure does that is by\
every time removing the last digit then printing it and repeating the process until ax=0. overall much simpler than the\
ScanNum procedure.\
##The important variables
To better understand the program I shall explain the important variables to you.\
the variables are:\

* `array` - this is the variable that stores the array.
* `counter` - this is the variable that stores the number of numbers in the array.
* `quotient` - this is the variable that stores the quotient of the average of all the numbers in the array.
* `remainder` - this is the variable that stores the remainder of the average of all the numbers in the array.
* `msg3` - this is the variable that stores the entire menu of the program.
## Possible future features
I would like to add new operations to the program in the future, like a procedure that will print the array, or maybe a procedure that will\
make you guess what number from the arrayit chooses based on the first digit of the number.

## Personal experience
It was very challenging to work on this project, if I thought I knew assembly before this project then I didn't it was 
really tough handling all the problems with assembly and my best advice is to not touch assembly because it is very hard 
but if you do learn assembly and do a big project then it is very rewarding. Doing this project got me to know how the
computer works and how just a tiny imperfection can make everything collapse. Before doing this project I hated assembly, and now I only dislike it.
