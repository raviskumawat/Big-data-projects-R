# to get the data from my google drive if not already downloaded,uncomment the following two lines
#train_url <- "https://drive.google.com/open?id=0ByQqscFZfvzcWjFkVWxnY0tYbTg"
#train1 <- read.csv(train_url)

#import the necessary libraries
library(readr)
library(dplyr)
library(party)
library(rpart)
library(rpart.plot)
library(ROCR)
library(ggplot2)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# set seed for constant output
set.seed(100)

#show first few entries of data
head(train)

#define the test split
test=tail(train)

#plot the number of males and females in each class
ggplot(train,aes(x=factor(Pclass),fill=factor(Sex)))+
  geom_bar(position="dodge")


ggplot(train,aes(x=factor(Pclass),fill=factor(Sex)))+
  geom_bar(position="dodge")+
  facet_grid(". ~ Survived")

posn.j <- position_jitter(0.5, 0)
ggplot(train,aes(x=factor(Pclass),y=Age,col=factor(Sex)))+
  geom_jitter(size=3,alpha=0.5,position=posn.j)+
  facet_grid(". ~ Survived")


#define the decision tree model
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")
#show the tree
fancyRpartPlot(fit)

#Predict the values for test data
my_prediction <- predict(fit, test, type = "class")

# Make a dataframe to show the output
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

#Print the predicted output
my_solution