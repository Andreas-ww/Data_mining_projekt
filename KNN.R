### Test med K nearest neighbours

knn_model <- train(form = V1 ~., 
                   data = train_data, 
                   method = "knn", 
                   # Standardiserar förklarande variabler
                   preProcess = c("center", "scale"), 
                   trControl = trainControl(
                     # Anger att korsvalidering ska köras
                     method = "repeatedcv", 
                     # Anger antalet k i k-fold korsvalidering, alltså inte k för KNN
                     number = 10, 
                     # Repeterar valideringen tre gånger
                     repeats = 3, 
                     # Anger att manuell val av utforskade k kommer ges, anges i tuneGrid
                     search = "grid"), 
                   # Anger vilka k som ska letas igenom i valideringen
                   tuneGrid = expand.grid(k = 1:5) 
) 

knn_model

new_pred <- predict(knn_model, 
                    newdata = val_data, 
                    # "raw" ger majoritetsklassen, 
                    # "prob" ger sannolikheterna (andelen) av grannar
                    type = "raw") 


class_evaluation(new_data = val_data, model = knn_model, true_y = val_data$V1, type = "raw")
