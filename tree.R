### Test decision tree 

tree <- rpart(
  formula = V1 ~ .,
  data = train_data,
  method = "class",
  # Anger föroreningsmått
  parms = list(split = "gini"), 
  
  control = list(
    ## Stopkriterier
    # Anger att antalet observationer som krävs för att en förgrening ska ske
    minsplit = 10,
    # Anger maxdjupet av träder, där 0 är rotnoden
    maxdepth = 30, 
    # Anger den minsta tillåtna förbättringen som måste ske för att en förgrening ska ske
    cp = 0,
    # Två inställningar som inte används mer i detalj
    maxcompete = 0,
    maxsurrogate = 0,
    
    ## Trädanpassning
    # Anger antalet korsvalideringar som ska ske medan modellens tränas, intern validering
    xval = 0, 
    # Tillåter att förgreningar har surrogatregler som kan användas vid saknade värden
    # Ska vara 2 om saknade värden finns i datamaterialet
    usesurrogate = 0
  )
)

## Sammanfattar alla noder, deras klassindelningar och fel
summary(tree, digits = 3) 


printcp(tree, digits = 3)
# Söker ut det cp-värde med minsta validerings-felet för beskärning av trädet
cp <- tree$cptable[which.min(tree$cptable[, "rel error"]), "CP"]

# Beskär trädet
tree_pruned <- prune(tree, cp = cp)

plot(tree, 
     # Justerar placeringen av noder
     uniform = TRUE,
     # Lägger till vita kanter för att inte texten ska försvinna utanför diagrammet
     margin = 0.05) 

## Lägger till information vid varje split i trädet
text(tree, 
     # Lägger till all information i förgreningen
     all = TRUE,
     # Styr storleken av texten som läggs till
     cex = 0.6) 


class_evaluation(new_data = train_data, 
                 model = tree, 
                 true_y = train_data$V1, 
                 digits = 3)

class_evaluation(new_data = val_data, 
                 model = tree, 
                 true_y = val_data$V1, 
                 digits = 3)


