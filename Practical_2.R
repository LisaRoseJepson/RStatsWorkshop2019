#2. Create a new Project in RStudio, and place it inside an appropriate directory on your computer. Verify the current working directory using the function getwd(). Import the data file you have just created into R, using the function read.csv(). If the file is inside a subfolder of your project’s directory, you will need to specify it. Remember to give the data frame a short and sensible name (e.g. dat, or farm).  

getwd()
farm <- read.csv("Practical_data.csv", header = T)

#3. Have a look at the data using the functions head()and str(). Is the data in tidy format? Then extract (i.e., print out in the R console) all variable names (using function names).

head(farm) #first 6 rows
tail(farm) #last 6 rows
str(farm) #structure

names(farm) #variable names
View(farm) #opens in s/sheet in R

#4. Extract all the values of Yield. Then extract the 5th value of Yield.

farm$Yield
farm$Yield[5]
farm[5, 1] # [row, column]

#5. Extract all the values in column 3. 

farm[, 3]

#Then extract the rows 50 to 60 of the data frame. 

farm[50:60, ]

#Finally, extract the values of Temperature and Depth for rows 15, 55 and 111.

farm[c(15, 55, 11), c("Temperature", "Depth")] #using names
farm[c(15, 55, 11), c(4, 5)] #using column numbers
farm[c(15, 55, 11), 4:5] #using colon

#6. Extract all the observations where the location was "Inshore". Try this using the base R approach (i.e., using square brackets) and the function filter from the tidyverse. You’ll need to install package tidyverse for the latter, and load it.

farm[farm$Location == "Inshore", ] #all rows where location = Inshore

library(tidyverse)
filter(farm, Location == "Inshore") #using Tidyverse filter()

#7. Extract all the observations where the feed was "Enriched" and the temperature was lower than 15°C, using the approach that you find most intuitive (either base R or the tidyverse approach).

farm[farm$Feed == "Enriched" & farm$Temperature < 15, ] #base R
filter(farm, Feed == "Enriched" & Temperature < 15) #Tidyverse

#8. Extract all the observations where the feed was "Basic", the location was "Offshore" and the depth was greater than the mean value of depth (note: you can nest functions within other functions).

farm[farm$Feed == "Basic" & farm$Location == "Offshore" & farm$Depth > mean(farm$Depth), ]
mean(farm$Depth)

#9. Order the data by decreasing order of Temperature. Then order it by Feed and, within each Feed category, by increasing order of Depth (function arrange). Look up the helpfile for arrange to see how to get values in decreasing order.

farm[order(farm$Temperature, decreasing = T),] # order by decreasing T
arrange(farm,desc(Temperature)) # Tidyverse option

?arrange
arrange(farm, Feed, Depth) # increasing depth
arrange(farm, Feed, desc(Depth)) # decreasing depth
farm[order(farm$Feed, farm$Depth),] # Base R

#10. Calculate the median Yield for each Location using the functions group_by and summarize.

summarize(group_by(farm, Location), medianYield = median(Yield))

by_Location <- group_by(farm, Location)
summarize(by_Location, medianYield = median(Yield, na.rm = TRUE))

#11. Calculate the median Yield for each Feed in each Location using the functions group_by and summarize.

summarize(group_by(farm, Location, Feed), medianYield = median(Yield))

by_LocationFeed <- group_by(farm, Location, Feed)
summarize(by_LocationFeed, medianYield = median(Yield, na.rm = TRUE))

#12. Create a new variable called Depth_neg containing the Depth of each observation expressed as a negative value (hint: use the function mutate).

farm <- mutate(farm, Depth_neg = 0-Depth)
farm <- mutate(farm, Depth_neg = (-Depth))
farm

#13. Have a look at the summary of your data frame, using the function summary(). Do you notice any NA values in any of the variables? Decide what to do with them (for example, you could create a
#2
#new data frame, with a new name, where you exclude all rows containing NAs, using the function
#na.omit().

summary(farm)

farm_rm <- na.omit(farm) # remove 1 row with missing Temp data
summary(farm_rm) # NA now removed

#14. Calculate the mean, median, minimum, maximum and standard deviation of Yield using the
#function summarize.

summarize(farm, mean = mean(Yield), median = median(Yield), min=min(Yield), max=max(Yield), sd=sd(Yield))

#15. Save your R script in RStudio, and export your modified data frame as a *.csv file called
#"Practical_data_modified.csv", using the function write.csv().

write.csv(farm_rm, "Practical_data_modified.csv", row.names = F)

#Optional 1. Read about the pipe operator %>% (package magrittr) here:
#https://magrittr.tidyverse.org/. Can you see the advantages? Any potential risk? Use the pipe operator
#to calculate the mean Yield (function summarize) for each Feed (function group_by) in the
#Offshore Location (function filter) in one command. You can find more examples of piping here:
#  https://moderndive.com/5-wrangling.html#piping.          
          
farm %>% 
  filter(Location == "Offshore") %>% 
  group_by(Feed) %>% 
  summarize(meanYield = mean(Yield))

#Optional 2. Create a new function called which_out that identifies which elements of a variable are
#outside a user-defined range (hint: use the function which, paired with the ‘or’ operator |). Use the
#new function to extract the elements of Yield that are either negative or greater than 700 kg/ha.

