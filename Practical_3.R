getwd()
farm <- read.csv("Practical_data.csv", header = T)

#1. Have a look at the summary of your data frame, using the function summary(). Do you notice any NA values in any of the variables? Decide what to do with them (for example, you could create a new data frame, with a new name, where you exclude all rows containing NAs, using the function na.omit().  

summary(farm)

farm_rm <- na.omit(farm) # remove 1 row with missing Temp data
summary(farm_rm) # NA now removed

#2. Create a boxplot of the variable Yield. How does the distribution look like? Do you notice any outliers? What would you do with them (i.e. are they mistakes or...?)? Use the function which() to identify the row number of the obvious mistake, and remove it from the data frame (use the help function to find out how which()operates).

boxplot(farm_rm$Yield) #2 extreme outliers

which(farm_rm$Yield < 0) # row 93
farm_rm[93, ]
farm_rm <- farm_rm[-93,] #remove row with negative yield (negative yield impossible)
#farm_rm <- farm_rm[-which(farm_rm$Yield < 0),] #alternative
#farm_rm <- filter(farm, Yield >0) #tidyverse alternative

which(farm_rm$Yield > 650) # row 130
farm_rm[130, ]
farm_rm <- farm_rm[-130,] #remove row with extreme outlier - this could stay?

boxplot(farm_rm$Yield) #no extreme outliers

#3. Create a histogram of the variable Yield using hist().

hist(farm_rm$Yield) #base R historgram

#Now try to make it using ggplot() (hint: you need geom_histogram())

library(tidyverse) #load tidyverse
#library(ggplot2) #or load ggplot2

ggplot(farm_rm, aes(x=Yield)) + 
  geom_histogram() #ggplot histogram - can set bin width e.g. (bins=30)

#4. Create a scatterplot of the variable Yield against Temperature using plot() and then using ggplot(). Try and change the colour of the dots, the symbol type, the title of the plot and the labels of the axes. How does the relationship between the variables look like?

plot(farm_rm$Temperature, farm_rm$Yield) #base R

plot(farm_rm$Temperature, farm_rm$Yield, main="Yield vs Temp") #title

plot(farm_rm$Temperature, farm_rm$Yield, main="Yield vs Temp", xlab="Yield", ylab="Temperature") #axes labels

plot(farm_rm$Temperature, farm_rm$Yield, main="Yield vs Temp", xlab="Yield", ylab="Temperature", col="purple") #change data point colour

plot(farm_rm$Temperature, farm_rm$Yield, main="Yield vs Temp", xlab="Yield", ylab="Temperature", col="purple", pch=17) #change data point shape

ggplot(farm_rm, aes(x=Temperature, y=Yield)) + 
  geom_point() #ggplot

ggplot(farm_rm, aes(x=Temperature, y=Yield)) + 
  geom_point() +
  theme_dark() #add theme

ggplot(farm_rm, aes(x=Temperature, y=Yield)) + 
  geom_point(size=3) +
  theme_dark() #change point size

ggplot(farm_rm, aes(x=Temperature, y=Yield)) + 
  geom_point(size=3) +
  theme_dark() +
  ggtitle("Yield vs Temp") #add title

ggplot(farm_rm, aes(x=Temperature, y=Yield, color=Yield)) + 
  geom_point(size=3) +
  theme_dark() +
  ggtitle("Yield vs Temp") #gradient colour for yield

ggplot(farm_rm, aes(x=Temperature, y=Yield)) + 
  geom_point(color="yellow", size=3) +
  theme_dark() +
  ggtitle("Yield vs Temp") #fixed colour

ggplot(farm_rm, aes(x=Temperature, y=Yield)) + 
  geom_point(color="yellow", size=3, shape=17) +
  theme_dark() +ggtitle("Yield vs Temp") + 
  theme(plot.title=element_text(hjust=0.5)) #change shape and centre title

#5. Create a boxplot of the variable Yield against the factor Location. What is this suggesting to you? How does the distribution of Yield look like within each habitat?

boxplot(farm_rm$Yield~farm_rm$Location) #use tilda not comma!
#summary(farm_rm$Location)
#summarize(group_by(farm_rm, Location), meanYield=mean(Yield))
ggplot(farm_rm, aes(x=Location, y=Yield)) +
  geom_boxplot()

#6. Use the function pairs() to evaluate any potential collinearity between the variables. Is there anything that jumps to your eye? What does this imply?

pairs(farm_rm)

#following code copied from ?pairs - puts on corrleation coefficient and trendlines

panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}
pairs(farm_rm, lower.panel = panel.smooth, upper.panel = panel.cor)

#Location (Estuary, Inshore, Offshore) and Depth collinear 

#7. Use facet_wrap() in ggplot() to plot Yield against Temperature for each Feed level.

?facet_wrap

ggplot(farm_rm, aes(x=Yield, y=Temperature)) +
  geom_point() +
  facet_wrap(~Feed)

ggplot(farm_rm, aes(x=Yield, y=Temperature)) +
  geom_point() +
  facet_wrap(vars(Feed)) #alternative
                                                                        
#8. Subset your data so that you have only the ‘Inshore’ and ‘Estuary’ factor levels from Location.

farm_rm_sub <- farm_rm[c(which(farm_rm$Location == "Inshore"), which(farm_rm$Location == "Estuary")),] #base R
View(farm_rm_sub)

#farm_rm_sub <- filter(farm_rm, Location == "Inshore" | Location == "Estuary") #alternative with tidyverse

# Now plot Yield against Temperature for each of these factor levels.

ggplot(farm_rm_sub, aes(x=Temperature, y=Yield)) +
  geom_point() +
  facet_wrap(~Location)

#9. Subset your dataframe so that you extract Depth values greater than mean Depth. Now plot Yield against Depth for this subset dataframe.

farm_rm_sub_depth <- filter(farm_rm_sub, Depth > mean(Depth))
View(farm_rm_sub_depth)

ggplot(farm_rm_sub_depth, aes(x=Depth, y=Yield)) +
  geom_point()
#plot(farm_rm_sub_depth$Depth, farm_rm_sub_depth$Yield)

#10. Save your R script in RStudio, and export your modified data frame as a *.csv file called "Practical_data_modified.csv", using the function write.csv(). This should have the outlier and any NAs removed. Be careful to include all the factor levels that you removed previously!

write.csv(farm_rm, "Practical_data_modified2.csv") # 2 outliers and NA excluded

#Optional 1. Use geom_smooth on your data with Temperature on the x-axis and Yield on the y-axis. Use the help function to find out what this function is doing. 

ggplot(farm_rm_sub, aes(x=Temperature, y=Yield)) +
  geom_point() +
  geom_smooth()

?geom_smooth

#Optional 2. Combine the pipe %>% operator with ggplot and filter to get Temperatures greater than 15 degrees and plot Yield against this subset.

farm_rm %>%
  filter(Temperature > 15) %>%
  ggplot(aes(x=Temperature, y=Yield)) +
  geom_point() 

#Optional 3. Explore the other geom options and apply them to your data. 

ggplot(farm_rm_sub, aes(x=Temperature, y=Yield)) +
  geom_point()

