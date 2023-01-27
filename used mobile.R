
#reading the data
setwd("C:/Users/DEEPIKA/Downloads")
device=read.csv("used_device_data.csv",na.strings = c(""))

#loading required packages
library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)
library(caretEnsemble)
library(doParallel)
library(corrplot)
library(dplyr)
library(e1071)
library(mlr)
library(caTools)
library(tidyr)
library(MLmetrics)

#summary statistics
summary(device)
str(device)

#checking missing values
table(is.na(device))
is.na(device)
table(is.na(device$rate))
sum(is.na(device))

#checking null values
table(is.null(device))
is.null(device)
sum(is.null(device))

#checking duplicate
table(duplicated(device))
device <- device[-which(duplicated(device)), ]

#filling missing values with mean
device$rear_camera_mp[is.na(device$rear_camera_mp)] <- mean(device$rear_camera_mp,na.rm=T)
device$front_camera_mp[is.na(device$front_camera_mp)] <- mean(device$front_camera_mp,na.rm=T)
device$internal_memory[is.na(device$internal_memory)] <- mean(device$internal_memory,na.rm=T)
device$ram [is.na(device$ram )] <- mean(device$ram ,na.rm=T)
device$battery[is.na(device$battery)] <- mean(device$battery,na.rm=T)
device$weight[is.na(device$weight)] <- mean(device$weight,na.rm=T)

#Outliers checking
bx=boxplot(device$screen_size)
bx=boxplot(device$ram)
bx=boxplot(device$rear_camera_mp)
bx=boxplot(device$front_camera_mp)
bx=boxplot(device$internal_memory)
bx=boxplot(device$battery)
bx=boxplot(device$weight)
bx=boxplot(device$release_year)
bx=boxplot(device$days_used)
bx=boxplot(device$normalized_used_price)
bx=boxplot(device$normalized_new_price)

device <- device[device$screen_size > quantile(device$screen_size, .25) - 1.5*IQR(device$screen_size) & 
                   device$screen_size < quantile(device$screen_size, .75) + 1.5*IQR(device$screen_size), ]

device <- device[device$rear_camera_mp > quantile(device$rear_camera_mp, .25) - 1.5*IQR(device$rear_camera_mp) & 
                   device$rear_camera_mp < quantile(device$rear_camera_mp, .75) + 1.5*IQR(device$rear_camera_mp), ]

device <- device[device$front_camera_mp > quantile(device$front_camera_mp, .25) - 1.5*IQR(device$front_camera_mp) & 
                   device$front_camera_mp < quantile(device$front_camera_mp, .75) + 1.5*IQR(device$front_camera_mp), ]

device <- device[device$internal_memory > quantile(device$internal_memory, .25) - 1.5*IQR(device$internal_memory) & 
                   device$internal_memory < quantile(device$internal_memory, .75) + 1.5*IQR(device$internal_memory), ]

device <- device[device$battery > quantile(device$battery, .25) - 1.5*IQR(device$battery) & 
                   device$battery < quantile(device$battery, .75) + 1.5*IQR(device$battery), ]

device <- device[device$weight > quantile(device$weight, .25) - 1.5*IQR(device$weight) & 
                   device$weight < quantile(device$weight, .75) + 1.5*IQR(device$weight), ]

device <- device[device$normalized_used_price > quantile(device$normalized_used_price, .25) - 1.5*IQR(device$normalized_used_price) & 
                   device$normalized_used_price < quantile(device$normalized_used_price, .75) + 1.5*IQR(device$normalized_used_price), ]

device <- device[device$normalized_new_price > quantile(device$normalized_new_price, .25) - 1.5*IQR(device$normalized_new_price) & 
                   device$normalized_new_price < quantile(device$normalized_new_price, .75) + 1.5*IQR(device$normalized_new_price), ]




##converting variable for 4G and 5G
device$X4g=ifelse(device$X4g=='no',0,1)
device$X5g=ifelse(device$X5g=='no',0,1)

#Plot for Used price vs New price
plot(y=device$normalized_used_price,x =device$normalized_new_price,xlab='normalized_new_price',ylab='normalized_used_price',col='red')

# plot for days used and used price
ggplot(device,aes(days_used,normalized_used_price))+geom_point()
 
#Plots for released year and used price
plot(y=device$normalized_used_price,x =device$release_year,xlab='release year',ylab='normalized_used_price',col='black')

#Plot for weight of the phone
ggplot(device,aes(weight,normalized_used_price))+geom_point(stat="identity")

#Plot for battery with phone
ggplot(device,aes(battery,normalized_used_price))+geom_point(stat="identity")

#Plot for ram 
ggplot(device,aes(ram,normalized_used_price))+geom_point(stat="identity")

#Plot for internal memory with price
plot(y=device$normalized_used_price,x =device$internal_memory,xlab='internal_memory',ylab='normalized_used_price',col='black')

#Plot for selfie camera
plot(y=device$normalized_used_price,x =device$front_camera_mp,xlab='Selfie_camera',ylab='normalized_used_price',col='black')

#Plot for main camera
plot(y=device$normalized_used_price,x =device$rear_camera_mp,xlab='rear_camera_mp',ylab='normalized_used_price',col='black')

#Plot for screen size
plot(y=device$normalized_used_price,x =device$screen_size,xlab='screen_size',ylab='normalized_used_price',col='black')

#Plot for os
ggplot(device,aes(os,normalized_used_price))+geom_point(stat="identity")

#Plot for brand name
ggplot(device,aes(normalized_used_price,device_brand))+geom_point(stat="identity")

#Plot for 4G and 5G compatibility
ggplot(device,aes(factor(X4g),normalized_used_price))+geom_bar(stat="identity")
ggplot(device,aes(factor(X5g),normalized_used_price))+geom_bar(stat="identity")

#Plot for brands offering os
ggplot(device,aes(normalized_used_price,device_brand,fill=os))+geom_bar(stat="identity")

##data visualization for each numerical variables 
ggplot(gather(device %>% select_if(is.numeric)), aes(value)) + 
  geom_histogram(bins = 10) + 
  facet_wrap(~key, scales = 'free_x')

#Data Exploration
#Avg price for 4G and 5G compatibility with top brands
device %>% 
  group_by(device_brand) %>% filter(X4g=='0') %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) 

device %>% 
  group_by(device_brand) %>% filter(X4g=='1') %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) %>% top_n(5)

device %>% 
  group_by(device_brand) %>% filter(X5g=='1') %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) 

#Avg price for OS
device %>% 
  select(os,normalized_used_price) %>% filter(os=="iOS") %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) 

device %>% 
  select(os,normalized_used_price) %>% filter(os=="Android") %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) 

device %>% 
  select(os,normalized_used_price) %>% filter(os=="Windows") %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) 

device %>% 
  select(os,normalized_used_price) %>% filter(os=="Others") %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) 

#Avg price for 4G and 5G
device %>% 
  select(X5g,normalized_used_price) %>% filter(X5g=='1') %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) 

device %>% 
  select(X4g,normalized_used_price) %>% filter(X4g=='1') %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) 

#Avg price with RAM 
device %>% 
  select(ram,normalized_used_price) %>% filter(ram<=3) %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) 

device %>% 
  select(ram,normalized_used_price) %>% filter(ram>3) %>% summarise(avgnormalized_used_price=mean(normalized_used_price)) 

#checking correlation between variables
cor1 <- device %>%
  select(-device_brand,-os)
correlationMatrix =cor(cor1)
cor(correlationMatrix)
corrplot(correlationMatrix)


#Splitting data
ran = createDataPartition(device$normalized_new_price, 
                          p = 0.7,                         
                          list = FALSE)

ran
device_train=device[ran,]
device_test=device[-ran,]

X = device[, -15]
y = device[, 15]

Xtrain = X[ran, ]
Xtest = X[-ran, ]
ytrain = y[ran]
ytest = y[-ran]

#Model building
#LM Model:

m1=lm(ytrain~.,Xtrain)
summary(m1)

#prediction:
p1=predict(m1,Xtest)
p1

#RMSE:
err=sqrt(mean((ytest-p1)^2))
err

#Random forest:
forest <- randomForest(ytrain~.,data=Xtrain,mtry=6,ntree=20,keep.forest=TRUE)

#prediction:
predict_forest=predict(forest,Xtest)
predict_forest

#RMSE:
err=sqrt(mean((ytest-predict_forest)^2))
err

#KNN:
knnFit <- caret::train(normalized_new_price ~ ., device_train, method = "knn", preProcess = c("center","scale"))

#prediction:
predict_knn=predict(knnFit,device_test)
predict_knn

#RMSE:
err=sqrt(mean((ytest-predict_knn)^2))
err

#Decision tree
tree <- rpart(ytrain~.,Xtrain)

#prediction
predict_tree=predict(tree,Xtest)
predict_tree

#RMSE:
err=sqrt(mean((ytest-predict_tree)^2))
err

#plot for test and model
plot(ytest,p1)
plot(ytest,predict_forest)
plot(ytest,predict_knn)
plot(ytest,predict_tree)

#Accuracy:
model_test=mean(abs(ytest-p1)/ytest)
accuracy_test=1-model_test
accuracy_test














