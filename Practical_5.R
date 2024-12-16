#You can now import the modified data file you have saved at the end of the previous Practical using the function read.csv(). Give a name to your data frame, and check it was imported correctly using head(). Alternatively, you can load the original data file, and rerun the script that you have written to prepare the data for analysis.

farm <- read.csv("Practical_data_modified2.csv", header = T)

head(farm)
tail(farm)
summary(farm)
View(farm)

#2. The aim of this Practical is to build a linear model to assess the relationship 
#between the annual yield of a farm and the average temperature of the water around the farm. 
#Make sure you understand what the objective of such a model is. 
#On a piece of paper, write down the equation of the model (using letters to indicate model coefficients).
#What is the response variable? What is the explanatory variable?

#Yieldi = a + b x Temperaturei + ei
# Response variable = Yield
# Explanatory variable = Temperature

#3. Fit a linear model in R to investigate the relationship between Temperature and Yield, 
#using the function lm(). 
#Remember to give a convenient name to the fitted model object.

fit1 <- lm(Yield~Temperature, data=farm) #response~explanatory
summary(fit1)

#4. Explore the summary of your model and make sure you understand what the different parts represent.
#How do you interpret the coefficient estimates? What are the standard errors around these estimates?
#How much variability in a farm's yield is explained by the average temperature at that farm? 
#Substitute the estimates in the model formula you have written on paper before.

#at Temperature = 0, Yield = 723
#with every 1C Temperature increase, Yield decreases by 23.5
#std errors intercept = 62.846 gradient = 4.176
#Multiple R-squared:  0.1794 -> 18% of variation explained by model 
#(Temperature affects yield, but isn't only explanation variable)

#Yield = 722.728 - 23.514 x Temperature

residuals(Fit1) # difference between fitted line and each point

#5. If we wanted to use a hypothesis test to assess the significance of the estimated relationship, 
#what would the null hypothesis be? Do the ANOVA of the model. 
#How do you interpret this result? 
#Can we reject the null hypothesis?

#H0: Temperature has no effect on yield

test <- aov(Yield~Temperature, data=farm)
summary.aov(test)

#P = 9.02e-08
#P < 0.05 -> reject H0

#6. It is now time to validate your model. 
#Use the function plot() to look at the residuals and assess whether model assumptions are met. 
#Make sure you understand what each of the four plots means.

par(mfrow=c(2,2))
plot(fit1)

#7. Use the equation of the model to calculate the expected yield
#when the temperature is 15°C.

722.728-23.514*15 # = 370.018
predict(fit1,newdata=data.frame(Temperature=15)) #alternative

#8. Create a scatterplot of Yield against Temperature. 
#Add the estimated relationship based on your linear model. 
#Add the 95% confidence intervals around your prediction 
#(hint: to plot the relationship estimated by your model, 
#you need to create a new dataset with values for the explanatory variables, 
#and then use the function predict() to calculate the fitted values 
#and the associated standard errors. 
#Confidence intervals are calculated as ± 1.96 * SE. 
#You can refer to the code in the lecture to carry out these tasks).

mydata <- data.frame(Temperature=seq(from=min(farm$Temperature), to=max(farm$Temperature), length =50))
View(mydata)
preds <- predict(fit1, newdata=mydata, se.fit=TRUE)
#farm$preds <- predict(fit1)

par(mfrow=c(1,1))
plot(farm$Temperature, farm$Yield, xlab="Temperature (C)", ylab="Yield (kg/ha)")
lines(mydata$Temperature, preds$fit, col="red")
lines(mydata$Temperature, preds$fit+(1.96*preds$se.fit), lty="dotted", col="red") #future sample regression line should be below this
lines(mydata$Temperature, preds$fit-(1.96*preds$se.fit), lty="dotted", col="red") #future sample regression line should be above this
