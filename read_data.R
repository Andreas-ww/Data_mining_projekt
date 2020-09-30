#setwd("C:/Users/andre/OneDrive - Linköpings universitet/Data mining projekt")

#Läser in data
data <- read.csv("letter-recognition.data")

#Skapar training / validation set
set.seed(1234)

train_index <- createDataPartition(data$T, p=0.7 , list=F)

train_data <- data[train_index,]

val_data <- data[-train_index,]

train_y <- train_data$T
val_y <- val_data$T

#TESTAR ATT LÄGGA TILL GITHUB