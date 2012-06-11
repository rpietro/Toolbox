#######################################################################################
#template_secondary_data_analysis.R is licensed under a Creative Commons Attribution - Non commercial 3.0 Unported License. see full license at the end of this file.
#######################################################################################
#this script follows a combination of the guidelines proposed by Hadley Wickham http://goo.gl/c04kq as well as using the formatR package http://goo.gl/ri6ky

#link to manuscript

#####################################################################################
#SETTING ENVIRONMENT
#####################################################################################
#remove all objects and then check
rm(list = ls())
ls()
#dettach all packages
detach()

#command below will install all packages and is only run once. remove the #if this is the first time you are running the code on RStudio, and then you can add the hash tag again
#lapply(c("ggplot2", "psych", "RCurl", "irr", "car","Hmisc", "gmodels", "DAAG"), install.packages, character.only=T)

lapply(c("ggplot2", "psych", "RCurl", "irr", "car","Hmisc", "gmodels","qpcR"), library, character.only=T)

#####################################################################################
#IMPORTING DATA AND RECODING
#####################################################################################

#if you are using a file that is local to your computer, then replace path below by path to the data file. command will throw all the data into the templateData object
templateData <- read.csv("/Users/rpietro/Google Drive/R/nonpublicdata/ERAS/eras.csv")


#below will view data in a spreadsheet format
#View(erasData)

#below will list variable names, classes (integer, factor, etc), alternative responses
str(templateData)
#list variable names so that they can be used later
names(templateData)
attach(templateData)

#STOPPED HERE

###########################################################################################
#TABLE 1: DEMOGRAPHICS
###########################################################################################

describe(erasData)

t.test(age~year)
t.test(bmi~year)
t.test(hgb~year)
t.test(creatinine~year)
#below doesn't work since the missing values for wbc overlap with the values where year = 0, leaving year with a single category
t.test(wbc~year)

#below is a function for testing multiple associations at the same time
# ttest.outcomes  <- function(integer.vector, predictor) 
#   {
#   data.frame(integer.vector, predictor) #equalizing vector length
#   for (i in integer.vector) 
#     t.test(i ~ predictor, na.action=na.exclude)
# }

CrossTable(year, female, chisq=TRUE, missing.include=TRUE, format="SAS", prop.r=FALSE)
CrossTable(year, asa2groups, chisq=TRUE, missing.include=TRUE, format="SAS", prop.r=FALSE)
CrossTable(year, difinal, chisq=TRUE, missing.include=TRUE, format="SAS", prop.r=FALSE)
CrossTable(year, operation, chisq=TRUE, missing.include=TRUE, format="SAS", prop.r=FALSE)
CrossTable(year, op2groups, chisq=TRUE, missing.include=TRUE, format="SAS", prop.r=FALSE)
CrossTable(year, laparoscopic, chisq=TRUE, missing.include=TRUE, format="SAS", prop.r=FALSE)
CrossTable(year, rac3groups, chisq=TRUE, missing.include=TRUE, format="SAS", prop.r=FALSE)

summary(bmi)
qplot(bmi)


kruskal.test(creatinine ~ year)
summary(creatinine~year)

########################################################################################
# TABLE 2
########################################################################################

#####################################################################################
#TABLE 3
#####################################################################################

model1  <- glm(atleastonecompl~year,family=binomial(link="logit"))
summary(model1) #gives you model results
coefficients(model1) # model coefficients
confint(model1, level=0.95) # CIs for model parameters 
fitted(model1) # predicted values
residuals(model1) # residuals
anova(model1) # anova table, something like anova(model1, model2) will compare two nested models
vcov(model1) # covariance matrix for model parameters 
influence(model1) # regression diagnostics
layout(matrix(c(1,2,3,4),2,2)) # creates the white space for 4 graphs/page 
plot(model1) #generates 4 graphs/page

summary(model1)
anova(model1)
confint(model1)

model2 <- glm(atleastonecompl ~ year + proclap + age + female + bmi + asa + operation + dg4gr, family=binomial(link="logit"))

str((atleastonecompl, year))# + proclap + age + female + bmi + asa + operation + dg4gr)

#Worni, this is new stata syntax and then i don't know what it means. if you shoot me an explanation i can give you the R equivalent
#Pietrobon, the xi: means that it takes categorical variables as categorical and not as continuous variables
# e.g. i.operation then means that it takes operation1 operation2 operation3 operation4 as categorical varialbes
# if you don't add the xi: .... i.*** then it would just run operation as a continuous variable, most likely, 
# in earlier times you had to recode to operation1 operation2 operation3 as categorical variables
### the i.epidural*year means, that I added the interaction term between i.epidural (most likely the i.*** would not be necessary) and year 

wilcox.test(los, year, conf.int = TRUE)

model2  <- ln_los ~ year + laparoscopic + age + female + bmi + asa + op1 + op2 + op3 + op4 + op5 + op6 + dg1 + dg2 + dg3 + dg4 #this is your regular model
year.pred  <- c(1,2) #these are the values you want to predict for
model2_hat  <- predict(model1, newdata=year.pred,interval="p", level=0.95)) #here you are using your original model to predict values as a function of specific years as you specified under year.pred
model2_hat #this command will show you the values

############################################################################
#TABLE 4
############################################################################
# nbreg restart_antibiotic year
#Worni, we went over this in a workshop, remember? http://goo.gl/5BMl1

#######################################################################################
#template_secondary_data_analysis.R is licensed under a Creative Commons Attribution - Non commercial 3.0 Unported License. You are free: to Share — to copy, distribute and transmit the work to Remix — to adapt the work, under the following conditions: Attribution — You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). Noncommercial — You may not use this work for commercial purposes. With the understanding that: Waiver — Any of the above conditions can be waived if you get permission from the copyright holder. Public Domain — Where the work or any of its elements is in the public domain under applicable law, that status is in no way affected by the license. Other Rights — In no way are any of the following rights affected by the license: Your fair dealing or fair use rights, or other applicable copyright exceptions and limitations; The author's moral rights; Rights other persons may have either in the work itself or in how the work is used, such as publicity or privacy rights. Notice — For any reuse or distribution, you must make clear to others the license terms of this work. The best way to do this is with a link to this web page. For more details see http://creativecommons.org/licenses/by-nc/3.0/
#######################################################################################
