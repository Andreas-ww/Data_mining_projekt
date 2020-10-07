#setwd("C:/Users/andre/OneDrive - Linköpings universitet/Data mining projekt")

#Läser in data
data <- read.csv("letter-recognition.data" , header = F)

colnames(data) <- c("Y", "x-box" , "y-box" , "width", "high", "onpix",
                    "x-bar" , "y-bar","x2bar","y2bar","xybar","x2ybr",
                    "xy2br", "x-ege","xegvy","y-ege","yegvx")


###förvandlar bokstavär till int // Behövs nog inte

# data$"Y" <- 0
# 
# for(i in 1:length(letters)){
# 
#   ind <- data$V1==LETTERS[i]
#  data$Y[ind] <- i-1
#  }

#Skapar training / test set
set.seed(1234)

#train_index <- createDataPartition(data$Y, p=0.8 , list=F)

train_index<- sample(1:nrow(data) , 16000)

train_data <- data[train_index,]

test_data <- data[-train_index,]


#Delar upp Responsvariabel och förklarande variabler
# train_y <- train_data$V1
# val_y <- val_data$V1
# 
# train_x <- as.matrix(train_data[,-1])
# val_x <- as.matrix(val_data[,-1])




