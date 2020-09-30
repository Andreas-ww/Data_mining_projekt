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
install_keras() 


# För att kunna använda keras behövs tensorflow i bakgrunden
# Denna kod behöver köras endast en gång
reticulate::conda_create("r-tensorflow")
tensorflow::install_tensorflow()
