### To apply natural background model to new data to predict natural background 
# specific electrical conductivity (EC)

# Packages
library(randomForest)

#Set to working directory conatining model (Ref10av2.rf.rds) and prediction data
#setwd("K:\\Data")

# download files from GitHub (if necessary)
# https://github.com/leppott/FreshwaterExplorerModel/tree/master/model
# "ExamplePredictionData.csv" and "Ref10av2.rf.rds"


#Read in model object
RF_Pred_NatEC <- readRDS(file = "Ref10av2.rf.rds") 

#Summary of model
RF_Pred_NatEC  

#Read in prediction data
df_Example_Predict_Data <- read.csv("ExamplePredictionData.csv", row.names="SampleID") 

# Show prediction data
df_Example_Predict_Data

#Check if all required predictors present and correctly labeled
CheckALL <- all(c("mET12avg","Precip1","Precip3avg","Precip6avg","Tmax0","Tmax2"
                  ,"CaO_Mean","S_Mean","UCS_Mean","AtmCa_AVE","KffactWs","ClayWs"
                  ,"WtDepWs","PermWs","PctConif","PctMxFst","PctShrb","PctGrs"
                  ,"PctHbWet") %in% colnames(df_Example_Predict_Data)) 

# Run if pass QC check "CheckALL"
if(CheckALL==TRUE){
  # Runs new site data through model to predict backgroung EC
  df_Example_Predict_Results <- predict(RF_Pred_NatEC, newdata=df_Example_Predict_Data) 
  
  #Saves predictions as csv
  write.csv(file="ExamplePredictionResults.csv", df_Example_Predict_Results)
}

# Show prediction results
df_Example_Predict_Results

