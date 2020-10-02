### Neurala nätverk

x_train <- train_x
x_test <- val_x

# Omstrukturerar kategorsk variabel till binär form
y_train <- to_categorical(train_data[, which(colnames(train_data) == "V1")], num_classes = 26)
y_test <- to_categorical(val_data[, which(colnames(val_data) == "V1")], num_classes = 26)


## Modell
# Skapar grundmodell
nn_model <- keras_model_sequential()

# Skapar arkitekturen
nn_model %>%
  ## Definierar första lagret, input_shape ska anges för att definiera hur många förklarande variabler som finns i data
  layer_dense(
    # Anger antal gömda noder i det GÖMDA lagret
    units = 256, 
    # Anger aktiveringsfunktionen i lagret
    activation = "relu", 
    # Det första gömda lagret anger hur många förklarande variabler som ska kopplas till lagret
    # Notera att input_shape styr input-lagret, units styr det gömda lagret
    input_shape = c(ncol(x_train)),
    # Anger att vi vill ha med en bias-term i lagret
    use_bias = TRUE, 
    name = "First"
  ) %>%
  ## Definierar andra lagret
  layer_dense(
    units = 128,
    activation = "relu",
    use_bias = TRUE,
    name = "Second"
  ) %>%
  ## Anger det sista lagret där antalet units är antalet kategorier
  layer_dense(
    units = 10, 
    activation = "softmax", 
    name = "Final/Output"
  )

## Anger en översiktsbild av den angivna arkitekturen
summary(nn_model)

## Definierar vilken anpassningsalgoritm som modellen ska skattas med
nn_model %>% compile(
  # Anger förlustfunktionen som vi vill använda. Denna styrs direkt av vilken typ av y-variabel som finns i data
  loss = 'categorical_crossentropy', 
  # Inlärningstakt av inkrementell inlärning
  optimizer = optimizer_sgd(lr = 0.01), 
  # Anger att träffsäkerheten ska användas som mått för utvärdering
  metrics = c('accuracy') 
)

## Anpassar modellen
history <- nn_model %>% fit(
  # Anger data
  x = x_train, y = y_train, 
  
  # Maximala antalet gånger alla observationer i träningsmängden ska gås igenom innan anpassningen avslutas
  epochs = 30, 
  
  # Anger hur många observationer som ska gås igenom innan vikterna uppdateras, här kan man ändra till batch-learning genom att ange nrow(x_train)
  batch_size = 128, 
  
  # Anger hur mycket av träningsdatat som ska användas som valideringsmängd. 
  # Plockar ur data indexerat från slutet, så var vaksam på att data måste vara slumpat innan
  # Om man har en separat valideringsmängd används validation_data = data
  validation_split = 0.25 
)

plot(history)

# Notera att för denna funktion måste y vara i klass-form, inte binärt som används i keras-funktionerna ovan
class_evaluation(new_data = x_train, 
                 model = nn_model, 
                 true_y = data_class_train$y)

class_evaluation(new_data = x_test, 
                 model = nn_model, 
                 true_y = data_class_test$y)