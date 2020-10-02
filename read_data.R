#setwd("C:/Users/andre/OneDrive - Linköpings universitet/Data mining projekt")

#Läser in data
data <- read.csv("letter-recognition.data" , header = F)

#Skapar training / validation set
set.seed(1234)

train_index <- createDataPartition(data$V1, p=0.7 , list=F)

train_data <- data[train_index,]

val_data <- data[-train_index,]


#Delar upp Responsvariabel och förklarande variabler
train_y <- train_data$V1
val_y <- val_data$V1

train_x <- as.matrix(train_data[,-1])
val_x <- as.matrix(val_data[,-1])

###förvandlar bokstavär till int

data$"Y" <- 0

for(i in 1:length(letters)){

  ind <- data$V1==LETTERS[i]
  data$Y[ind] <- i}

}

