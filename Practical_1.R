#1. Start RStudio, open a new R script, and save the current session with a relevant name (e.g.
                                                                                          "Practical_1"). This will contain the script of all your R code from this Practical.
#2. Explore the different windows of RStudio. Where is the script editor? Where is the R Console?
#  How are the two connected? Where can you see the objects present in your environment?

#3. Create an object called A equal to 12, and an object called B equal to 63. Then use R to calculate
#their product, and store this as an object called product.

a <- 12
b <- 63
product <- a*b

#4. Explore the help file of the function mean, using the command ?mean. Can you identify the
#arguments (inputs) required by the function, and the output? Add some comments to your R script
#(using the symbol #) to summarise what the function does.

?mean #mean help function

#mean(x, trim = 0, na.rm = FALSE, ...)

numbers <- c(1.2, 2.5, 2.6)

x <- c(41, 35, 2, NA)
mean(x) # returns "NA" due to missing data
mean(x, na.rm = TRUE) # ignores missing data and calculates mean on remaining data

#5. Use the function c() to create a vector called age , containing 5 values: 30, 18, 25, 27, 15.

age <- c(30, 18, 25, 27, 15)

#6. Calculate the mean, median and standard deviation (hint: use function sd) of vector age.

mean(age) # 23
median(age) # 25
sd(age) # 6.284903

#7. Extract the second value of the vector. Then extract (using a single command!) the first, fourth
#and fifth values. Finally, change the third value of the vector to 24.

age[2] # second argument = 18
age[c(1, 4, 5)] # first, fourth, fifth argument = 30 27 15
age[3] <- 24 # change third value to 24

#8. Multiply all values in the vector by 2.
age * 2 # = 60 36 48 54 30

#9. Create a vector called name, including the strings: "John", "Paul", "Lucy", "Martha" and "Jennifer".

name <- c("John", "Paul", "Lucy", "Martha", "Jennifer")

#Combine vectors age and name into a new data frame (using function data.frame), and reorder
#it based on the order of age (ascending).

?data.frame
dat <- data.frame(Name=c(name), Age=c(age))
dat
order(dat$Age) #"$" refers to column in dataframe #order returns rank
age
dat <- dat[order(dat$Age),] #uses order as the row number, to define the new row number


#10. Install package ggplot2 using the relevant functionality in the “Packages” tab in RStudio, then
#load it in R using the function library.

library(ggplot2)

#11. Create a matrix with 2 rows and 3 columns, containing a sequence of values from 1 to 36 by an
#increment of 6 (hint: use the help files of functions matrix and seq for details on their usage).
#Don’t forget to give the new object a name of your choice.

?matrix
?seq
seq.int(6, 36, 6)

mat1 <- matrix(seq.int(1, 36, 6), nrow = 2)
mat1

#12. Extract all elements in the first row of the array. Then extract all elements in the second column.
#Then extract the third element of the second row.

mat1[1, ] #row 1 = 1 13 25 [row, column]
mat1[,2] #column 2 = 13 19
mat1[2, 3] #third element of second row = 31

#13. Test if the third element of the second row in the array is greater than 25. Then test if it is equal
#to 30.

mat1[2, 3] > 25 #TRUE
mat1[2, 3] == 30 #FALSE

#14. Test if the third element of the second row in the array is greater than 25 and equal to 30. Then
#test if the same element is greater than 25 or equal to 30. Do you understand why you get a
#different answer?

mat1[2, 3] > 25 & mat1[2, 3] == 30 #FALSE
mat1[2, 3] > 25 | mat1[2, 3] == 30 #TRUE

#Optional 1. Explore the help file and examples for function using help("function"). Then
#create a customized function called area to calculate the area of a circle, given the radius r (hint:
#                                                                                                  2
#                                                                                                the formula for the area of a circle is π∙r2). Test the function by finding the area of a circle with a
#radius of 3.4 cm. Can you use it on a vector of data?

help("function")

area <- function(radius) pi * radius^2
area
area(3.4)

area(numbers[2])
area(numbers) # R applies functions to all objects in a vector

#Optional 2. Create a vector of 1000 uniformly distributed numbers between 0 and 100 (function
#runif). Round their values to the second decimal place (function round). Then sample 10 random
#                                                                                          values from the vector, with and without replacement (function sample).

?runif
?round

unidist <- runif(1000, round(0, digits = 2), round(100, digits = 2))
unidist2 <- round(runif(1000, 0, 100), digits = 2)

?sample

sample(unidist, 10, replace = FALSE)

#Optional 3. Create a vector of 100 random integers between 0 and 500 (hint: use the function
#sample to sample from the sequence 0:500 with replacement). Use function %in% to test whether
#                                                                                          the vector contains the number 10.                 

randint <- sample(0:500, replace = TRUE)

help("%in%")

10 %in% randint  

#Optional 4. Generate the following sequences (hint: use function rep, and check the use of
#                                              arguments times and each):
#  i) 1 2 3 1 2 3 1 2 3
#                                                                                          ii) 1 1 1 2 2 2 3 3 3
#                                                                                          iii) 1 1 1 2 2 2 3 3 3 1 1 1 2 2 2 3 3 3
#                                                                                          iv) 1 1 1 1 1 2 2 2 2 3 3 3 4 4 5

?rep

rep(c(1, 2, 3), 3)
c(rep(1, 3), rep(2, 3), rep(3, 3))
rep(c(rep(1, 3), rep(2, 3), rep(3, 3)), 2)
c(rep(1, 5), rep(2, 4), rep(3,3), rep(4, 2), rep(5, 1))
