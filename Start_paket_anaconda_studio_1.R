# install.packages("dplyr")
# install.packages("tidyr")
# install.packages("stringr")
# install.packages("lubridate")
require(dplyr)
require(tidyr)
require(stringr)
require(lubridate)


## Visualisering
# install.packages("ggplot2")
# install.packages("RColorBrewer")
# install.packages("lattice")
# install.packages("plotly")
require(ggplot2)
require(RColorBrewer)
require(lattice)
require(plotly)

## Beslutsträd
#install.packages("rpart")
require(rpart)

## KNN
# install.packages("caret")
# install.packages("e1071")
# install.packages("kknn")
require(caret)
require(e1071)
require(kknn)

## Neurala nätverk
# install.packages("keras")
require(keras)

# ## Klustring
# install.packages("cluster")
# install.packages("dbscan")
# install.packages("kohonen")
require(cluster)
require(dbscan)
require(kohonen)

## Associationsanalys
# install.packages("arules")
require(arules)

## Sekvensanalys
# install.packages("arulesSequences")
require(arulesSequences)



#Installation av keras
# Körs endast en gång vid installation av paketet
#install_keras() 


# För att kunna använda keras behövs tensorflow i bakgrunden
# Denna kod behöver köras endast en gång
#reticulate::conda_create("r-tensorflow")
#tensorflow::install_tensorflow()



class_evaluation <- function(new_data, model, true_y, type = "class", digits = 3){
  # Predikterar klassen för new_data givet den skattade modellen
  if(any(str_detect(class(model), pattern = "keras"))){
    pred <- predict_classes(model, new_data)  
  } else {
    pred <- predict(model, newdata = new_data, type = type)  
  }
  
  # Konverterar de predikterade klasserna till en faktor med samma nivåer som de sanna klasserna
  pred <- factor(pred, levels = levels(factor(true_y)))
  
  # Skapar förväxlingsmatris med rader som indikerar sanna klassen och kolumnen som indikerar predikterade klassen
  confusion <- table(true_y, pred)
  
  # Träffsäkerhet är antalet korrekta prediktioner dividerat med antalet observationer
  accuracy <- sum(diag(confusion)) / sum(confusion)
  
  # Felkvoten är 1 - träffsäkerheten
  misclass <- 1 - accuracy
  
  # Sensitivitet är antalet korrekta prediktioner AV DEN NUVARANDE KLASSEN dividerat med antalet observationer AV DEN NUVARANDE KLASSEN
  sensitivity <- diag(confusion) / rowSums(confusion) 
  
  # Specificitet är antalet korrekta prediktioner AV ICKE DEN NUVARANDE KLASSEN dividerat med antalet observationer AV ICKE DEN NUVARANDE KLASSEN
  specificity <- NULL
  for(i in 1:nrow(confusion)){
    specificity[i] <- sum(confusion[-i, -i])/sum(confusion[-i, ])
  }
  
  # Sammanställer alla resultat i en egen lista som sedan returneras
  evaluation <- list(confusion_matrix = confusion, 
                     overall = 
                       cbind(acc = accuracy, 
                             mis = misclass),
                     class_wise = 
                       rbind(sensitivity = round(sensitivity, digits = digits),
                             specificity = round(specificity, digits = digits))
  )
  
  return(evaluation)
}
