                                                  USED-MOBILE-PRICE-PREDICTION
                                   
          
          ![second-hand-mobile-phones-smartphones-D14C13](https://user-images.githubusercontent.com/122966157/215050787-17140f19-ef54-4ec3-942a-b780023d37f0.jpg)

          
          
          
          
                                                                   
                             
 OBJECTIVE:
   
        To predict the price of a used phone/tablet and identify factors that significantly influence it.
        
 DATA DESCRIPTION:

        The data contains the different attributes of used/refurbished phones and tablets.        
        
        It contains 15 features and 3455 rows. The detailed attributes is given below in the summary statistics:

METHADOLOGY:
 
        We will proceed with reading the data, and then perform data analysis. The practice of examining data using analytical or statistical methods in order to identify meaningful information is known as data analysis. After data analysis, we will find out the data distribution and data types. We will train 4 regression algorithms to predict the output.
        
       Using R we can perform the analysis by the folowing ways:

 Datacleaning - It is the process like find out the outliers,missing values,duplicate and fill the missing values,removing outliers,removing
               features with less or no importance       
 
 Visualization - Using 'ggplot' we can create a plots and provides helpful commands to create complex plots from data in a data frame. 
 
 Exploratory Data Analysis -  provides a better understanding of data set variables and the relationships between them.
                              'dplyr' is a package for making data manipulation easier.
 
 Feature selection -Identify those attributes that are and are not required to build an accurate model.                             
 
 Building models -Multiple linear regression,Random forest,KNN,Decision tree  
 
 Predict the models with test data
 
 Checking the accuracy for the prediction
 
 ->The vision of the dataset has been given below:
 
                                                    MACHINE LEARNING ANALYSIS
                                                     
 SUMMARY STATISTICS:
 device_brand	
os	
screen_size	
4g	
5g	
rear_camera_mp
front_camera_mp
internal_memory	
ram	battery	
weight	
release_year	
days_used	
normalized_used_price	
normalized_new_price(TARGET VARIABLE)

MISSING VALUES:

While analysis we found that 6 (rear_camera_mp,front_camera_mp,internal_memory,ram,battery,weight)features that has missing value issues. Lets impute this by mean of the features.

OUTLIERS:

Checking the ouliers using "BOXPLOT" and impute with IQR.

DATA MANIPULATION/FEATURE ENGINEERING:

Converting variables 4G and 5G to Numeric

DATA VISUALIZATION:(Using"GGPLOT")

    While Visualizing the plots below points are came to know:
         *We can see the  relationship between new and used price is linear,the price of new phone is increasing the price off used phone is also increasing.
         *The days used and used price looks like more or less relationship.
         *Phones from recent year(newer phones) fetching a high price.
         *weight of the phone has not that much relation with price since its a random scatter.
         *seems like some of the positive relations if the battery is increasing price is also increasing but slightly.
         *RAM with 4,6,8 leads to higher price.
         *10 to 25 mega pixel phones prices are in the higher range.
         *Price is more when the rear camera is higher resolution.
         *Windows phone does not fetching a high amount of money so if someone selling a used phone which is based on windows it will not give them the value for the               phone,ios and andriod has the good distribution.
         *Apple,huawei,samsung,oppo being one of the brands is getting highest price for used phones .Local brand mobiles are not getting higher price and Microsoft               adopting windows price ranges are very less
         *There is big difference in price if the phone is supported 4G or not.
         *Nokia has the equal share of Android,others,Windows

DATA EXPLORATION(EDA):(Using dplyr)

         *If the phone is 4g then the highest value that on an average a phone is fetching for oneplus followed by Apple.
         *If the phone is 5G then the brand sony is in top.
         *Highest Avgprice is for iOS followed by Android,windows and others.
         *Avg price of phone with 5G supported is higher than the 4G.
         *The  highest price range is in  If the phone has the RAM greater than 3.
         
CORRELATION BETWEEN VARIABLES:
     
         *If the screen size is increase the battery is increase
         *The more latest phone has the highest resolution of front camera
         *But that there is no multi colinearity issue

-> Data splitting for Test and Train data using CARET.

-> Model Building :

                 *Multiple linear regression

                 *Random forest
                 
                 *KNN
                 
                 *Decision tree 

-> Predicting the model in test data.

-> Check the RMSE for prediction and Actual.

 
 
 
