### Test med K nearest neighbours

knn_model <- train(form = Y ~., 
                   data = train_data, 
                   method = "knn", 
                   # Standardiserar förklarande variabler
                   preProcess = c("center", "scale"), 
                   trControl = trainControl(
                     # Anger att korsvalidering ska köras
                     method = "repeatedcv", 
                     # Anger antalet k i k-fold korsvalidering, alltså inte k för KNN
                     number = 3, 
                     # Repeterar valideringen tre gånger
                     repeats = 3, 
                     # Anger att manuell val av utforskade k kommer ges, anges i tuneGrid
                     search = "grid"), 
                   # Anger vilka k som ska letas igenom i valideringen
                   tuneGrid = expand.grid(k = 1:10) 
) 

plot(knn_model ,xlab="K" , ylab="Precision" , main="Val av K för KNN")


new_pred <- predict(knn_model, 
                    newdata = test_data, 
                    # "raw" ger majoritetsklassen, 
                    # "prob" ger sannolikheterna (andelen) av grannar
                    type = "raw") 

table(new_pred, test_data$Y)

eval <-class_evaluation(new_data = test_data, model = knn_model, true_y = test_data$Y, type = "raw")

kable(eval$confusion_matrix , format="latex" , linesep="" , caption="Förväxlingsmatris", label="cv" , booktabs=F, align="c", position="H" , digits=6)
kable(eval$overall , format="latex" , linesep="" , caption="Precision och felkvot", label="overall" , booktabs=T, align="c", position="H")
l<- list(t(eval$class_wise[1,1:13]),t(eval$class_wise[1,14:26]))
t(l)
kable(l , format="latex" , linesep="-" , caption="Klassvis", label="klass" , booktabs=T, align="c", position="H" )






