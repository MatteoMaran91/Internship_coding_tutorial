# -*- coding: utf-8 -*-
"""
Hi. These are few lines of code that can give you an idea of useful functions etc to start with Python 2.
Many problems can be solved with multiple coding solutions. I think that the most important aspect of coding is
really thinking about the steps you need, how you can extract info, how to store it and manipulate it for easy access.

Sometimes it can be a bit frustrating but it is really a learning by error and finding creative solutions to problems.
Google and https://stackoverflow.com/ can be helpful in finding out how the functions are called in python, and maybe you will
find people who were facing the same problem as you (e.g. how can I extract this info?). It can be good to have a look at how they
did it, but try always to come up with your solution or at least to fully understand the line of code that you are copying and
pasting (I do that as well and it is not necessary a bad thing.) 

And of course, you can always write me an email or drop by if there is some trouble with coding:)

@author: maran@cbs.mpg.de
"""
#####################################################            
## MAIN DATA TYPE (see https://www.tutorialspoint.com/python/python_variable_types.htm)
# Numbers:
my_int = 7;          # integer
my_float = 7.5 ;    # float

# Strings
my_string = 'Hello world!';
my_num_string = '7';

# List
my_list_of_strings = ['pizza', 'zucchini', 'kebab', 'salami']           # contains multiple elements
my_list_of_num = [1,6,14,3]
my_mixed_list = ['1',1]

# Functions can be used to convert data
str(my_int)             # convert to a string
int(my_float)           # convert to int
int(my_num_string)      # convert to int
float(my_int)           # convert to float

# We will later see how to add elements to a list that already exists


#####################################################
## INDEXING
# Indexing allows to take specific elements of a variable
my_numbers = [67, 32, 1000, 1001];  # this is a list 
my_numbers[0]           # first element of the list (indexing starts from 0)
my_numbers[1]
my_numbers[2]
my_numbers[3]

# The index cannot exceed the number of elements of a variable    
my_numbers[4]     # there is no position number 5 in my_numbers since it has only 4 elements

# Indexing can also be used with strings:
my_city = 'Leipzig';
my_city[0]        # first character of the string my_city
my_city[3]

# Nested indexing
my_list_of_strings[0][0]  # first character of first element of my list of strings


#####################################################
## FOR LOOPS

# Use loops to repeate some operations a certain number of times
for i in range(0,5):
    print('wow')

food_list = ['pizza', 'kebab', 'zucchini'];
for i in range(0,len(food_list)):   # for i going up to the length of food_list
    print(i);                       # print i
    print(food_list[i]);            # print the element of food_list in position number i

# Use loops for iterate over a list
for food in food_list:                  # for each element in food_list do the following lines of code (in this example print)
    print(food)
      
# Use loops for taking at each iteration a different element
# Type:
food_list[0]    # first element of food_list  (indexing in python starts from 0)
food_list[1]    # second element of food_list
food_list[2]    # third element of food_list
len(food_list)  # length of food_list. en returns the number of elements of a variable
    
    

    

# You can have nested for loops:
for food in food_list:              # for each element of food_list
    for i in range(0,2):            # do twice:
        print(food);                # print food


#####################################################
## IF/ELIF/ELSE STATEMENTS
# Use if statements to run certain lines of code only if a condition is true

'pizza'.startswith('p')     # .startswith after a string returns True or False according to the first letter of the string
'zucchini'.startswith('p')  # does 'zucchini' start with 'p'?     > returns False
'pizza'.startswith('P')     # case sensitive

if 'pizza'.startswith('p'):
    print('cool it starts with p')
  
# You can have multiple conditions  
if 'zucchini'.startswith('p'):          # if it starts with 'p' print 'cool it starts with p'
    print('cool it starts with p')
elif  'zucchini'.startswith('z'):       # and if it starts with 'z' print 'cool it starts with z'
    print('cool it starts with z');
else:                                   # in all other case print 'it does not start with p or z'
    print('it does not start with p or z');


if 'kebab'.startswith('p'):          # if it starts with 'p' print 'cool it starts with p'
    print('cool it starts with p')
elif  'kebab'.startswith('z'):       # and if it starts with 'z' print 'cool it starts with z'
    print('cool it starts with z');
else:                                   # in all other case print 'it does not start with p or z'
    print('it does not start with p or z');    
    

# YOU CAN COMBINE LOOPS AND IF STATEMENTS
for food in food_list:                # for each element in food_list
    if food.startswith('p'):          # if it starts with 'p' print 'cool it starts with p'
        print('cool it starts with p')
    elif  food.startswith('z'):       # and if it starts with 'z' print 'cool it starts with z'
        print('cool it starts with z');
    else:                                   # in all other case print 'it does not start with p or z'
        print('it does not start with p or z');
        
# Have a look at https://www.tutorialspoint.com/python/comparison_operators_example.htm   for value comparison to be used in if statement
for food in food_list:      
    if food == 'zucchini':              # if it is equal to 'zucchini'
        print(food)
    else:                           
        print('nope')


#####################################################
## APPEND TO LISTS

# Add eleements to a list
shopping_list = ['coffee', 'milk'];
shopping_list.append('chocolate');      # append 'chocolate' to our shopping_list
shopping_list

# Appending to list can be very helpful to store data that we will encounter later on
data_list = [];         # initialize as an empty list
for vali in range(0,8):     # for a variable vali tha ranges from 0 to 7
    data_list.append(vali)  # append the value of vali to the list
    
# Check now data_list
data_list


#####################################################
## CONCATENATE STRINGS

a = 'AAAA';
b = 'BBBB';
c = a+b
d = a + '\t' + b + '\n' + b + '\t' + a      # I have added also two tabs and new line

# Check d
d

# When using print we can see the tabs and new lines
print(d)


#####################################################
## READ A .TXT FILE AND SPLIT LINES

# Define file name
fold_with_file = '/home/raid2/maran/The neural basis of merge/Internship_anna/';     # folder where I have my file
file_to_open = fold_with_file + 'Subj1_Session_1_Block1_pancaro.txt';   # we create the full path to the file by concatenating two strings

# Store the lines of the file to the list orig_lines
with open(file_to_open, 'r+') as orig_file:
    orig_lines = orig_file.readlines();
    
# Check orig_lines
orig_lines              # wow that's a lot of info

# Let's check a random line, for example line with index 112
chosen_line = orig_lines[112]
chosen_line             # still a bit messy
print(chosen_line)      # that's much better

# Now let's see how to split the lines every time there is a tab
split_line = chosen_line.split();
split_line          # chosen line is now split in a list

# Splitting makes it easier to access info. Let's say I want only info from the third column. I can use indexing :)
split_line[0]
split_line[1]
split_line[2]
#etc etc

# Replace new line character
test_line = chosen_line + chosen_line;
test_line.replace('\r\n', '')           # remove = replace with nothing
print(test_line.replace('\r\n', '\t'))


#####################################################
## PRINT TO A .TXT FILE

# Define filename
out_filename = fold_with_file + 'my_output.txt';

# Define string to print
string_to_print = 'Hello hello hello'

with open(out_filename, 'a') as my_output:          # my_output is a sort of variable redirecting to out_filename
    my_output.write(string_to_print)                # write (append mode) to my_output the string_to_print

# You need to indicate when a new line comes with '\n'
out_filename = fold_with_file + 'my_output_no_space.txt';
with open(out_filename, 'a') as my_output:          # my_output is a sort of variable redirecting to out_filename
    my_output.write(string_to_print)                
    my_output.write(string_to_print)
    
out_filename = fold_with_file + 'my_output_with_newline.txt';
with open(out_filename, 'a') as my_output:          # my_output is a sort of variable redirecting to out_filename
    my_output.write(string_to_print) 
    my_output.write('\n')                 
    my_output.write(string_to_print)
    
# The '\n' can just be concatenated to the first string
out_filename = fold_with_file + 'my_second_output_with_newline.txt';
with open(out_filename, 'a') as my_output:          # my_output is a sort of variable redirecting to out_filename
    my_output.write(string_to_print + '\n' + string_to_print);

# Now let's create a tabulated file 
out_filename = fold_with_file + 'my_tab_file.txt';
tab_string_to_print = 'name' + '\t' + 'surname' + '\t' + 'fav_col' + '\n';
tab_string_to_print = tab_string_to_print + 'anna' + '\t' + 'bliss'+ '\t' + 'red?' + '\n'
with open(out_filename, 'a') as my_output:
    my_output.write(tab_string_to_print)




