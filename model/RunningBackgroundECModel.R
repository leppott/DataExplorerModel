### To apply natural background model to new data to predict natural background specific electrical conductivity (EC)
library(randomForest)

setwd("K:\\Data")#Set to working directory conatining model (Ref10av2.rf.rds) and prediction data

RF_Pred_NatEC<-readRDS(file = "Ref10av2.rf.rds") #Read in model object

RF_Pred_NatEC #Summary of model 

Example_Predict_Data<-read.csv("ExamplePredictionData.csv", row.names="SampleID") #Read in prediction data

Example_Predict_Data

all(c("mET12avg","Precip1","Precip3avg","Precip6avg","Tmax0","Tmax2","CaO_Mean","S_Mean","UCS_Mean","AtmCa_AVE","KffactWs","ClayWs","WtDepWs","PermWs","PctConif","PctMxFst","PctShrb","PctGrs","PctHbWet") %in% colnames(Example_Predict_Data)) #Check if all required predictors present and correctly labeled

Example_Predictions<-predict(RF_Pred_NatEC, newdata=Example_Predict_Data) # Runs new site data through model to predict backgroung EC

write.csv(file="Example_Predictions.csv", Example_Predictions)#Saves predictions as csv

