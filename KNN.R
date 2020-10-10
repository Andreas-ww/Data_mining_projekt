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

class_evaluation(new_data = test_data, model = knn_model, true_y = test_data$Y, type = "raw")
