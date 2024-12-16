#1. Have a look at your notes from the previous Practical. 
#The dataset we are analysing contains the annual yield ("Yield", in kg/ha) of 150 fish farms located 
#in three different habitats ("Location"). 
#Some farms have used a standard fish feed ("Basic"), while others have adopted an enriched formula
#that should increase the annual yield ("Enriched"). 
#Information on the average water temperature ("Temperature") and depth ("Depth") at the farms 
#is also provided. Remember we have already carried out data exploration. 
#We have excluded NAs and checked for outliers. 
#We also plotted the distribution of the variable of interest (Yield), 
#visually investigated any potential relationship with the provided explanatory variables, 
#and assessed any collinearity between them. 
#You can now import the modified data file you have saved at the end of the previous Practical using the function read.csv().
#Give a name to your data frame, and check it was imported correctly using head().

farm <- read.csv("Practical_data_modified2.csv", header = T)

head(farm)

#2. Calculate some descriptive statistics for the variable of interest (Yield); 
#e.g. the mean, median, range and standard deviation.

summary(farm$Yield) # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
                    #52.4   285.8   386.0   372.5   446.2   633.3 
sd(farm$Yield)  #119.2061

#3. Calculate the mean Yield of farms using different Feed.

summarise(group_by(farm, Feed), meanYield=mean(Yield))

#4. You want to determine if there was a significant difference in Yield between farms 
#using different Feed. First, plot your data using a boxplot. 
#What is the null hypothesis? What is the alternative hypothesis? 
#Use a Student’s t-test to test this difference. What does the result suggest? 
#Can you reject the null hypothesis? 
#Use the non-parametric equivalent to a t.test with wilcox.test() Does this change the interpretation? 

#WARNING: for the moment, we are simply assuming that the assumptions of this hypothesis test are met, 
#and hence the test is valid. 
#In the next lecture and practical we will discuss how to check the assumptions of normality, 
#homoscedasticity and independence using residual plots.

ggplot(farm, aes(x=Feed, y=Yield)) +
  geom_boxplot()                      #using ggplot

#boxplot(farm$Yield~farm$Feed)        #using Base R

#H0: No difference in yields; H1: difference in yields

t.test(farm$Yield[farm$Feed == "Basic"], farm$Yield[farm$Feed == "Enriched"])

#Results suggest no significant difference: Accept H0 (p-value = 0.2662)

?wilcox.test
wilcox.test(farm$Yield[farm$Feed == "Basic"], farm$Yield[farm$Feed == "Enriched"])

#Results suggest no significant difference: Accept H0 (p-value = 0.3475)

#5. Calculate the mean Yield of farms in different habitats (that is, by Location).

summarise(group_by(farm, Location), meanYield=mean(Yield))

#6. You now want to assess if there was a significant difference in Yield between farms 
#in different habitats. 
#First, plot your data using a boxplot. 
#What is the null hypothesis? 
#What is the alternative hypothesis? 
#Use an ANOVA test to test this difference. 
#How do you interpret the result? Can you reject the null hypothesis? 
#Use the non-parametric equivalent to an ANOVA with kruskal.test() 
#Does this change the interpretation? 
#The same WARNING regarding the assumptions of the test applies here.

ggplot(farm, aes(x=Location, y=Yield)) +
  geom_boxplot()                         #using ggplot

#boxplot(farm$Yield~farm$Location)        #using Base R

#H0: No difference in yield between locations; H1: Difference in yield between locations

test <- aov(Yield~Location, data = farm)
summary(test)

#Reject H0 - difference in yield between locations (location influences yield) (p=0.00108)

test2 <- kruskal.test(Yield~Location, data = farm)
test2

#interpretation remains the same (p-value = 0.001944)

#7. The ANOVA test indicates whether any of the Location means are different, 
#but we don’t know which pairs of Location levels are different. 
#Carry out post-hoc comparisons on the results of the ANOVA test 
#using Tukey Honestly Significant Differences to evaluate the pairwise differences among habitats. 
#What do you conclude? 

TukeyHSD(test)

#Significant difference in yield between Offshore-Estuary and Offshore-Inshore; Inshore-Estuary not significantly different

#Optional 1. Install the package lsr with install.packages()
#and use the cohensD function on the comparison you made in question 4 with the t.test 
#What does the value tell you about the effect size? 

#install.packages("lsr")
library(lsr)

cohensD(farm$Yield[farm$Feed == "Basic"], farm$Yield[farm$Feed == "Enriched"])

#Effect size is small (small = 0.2; moderate = 0.5; large = 0.8)
#Effect that the feeds have on the yield is small