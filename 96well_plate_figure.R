library(tidyverse)

#dimentions of the plate
y <- 1:8
x <- (1:12)/1.5
t <- as.data.frame(expand.grid(x,y)) 
names(t) <- c("x", "y")
t <-t %>% arrange(desc(y))

#Generating a vector for the coatings of the plate. 
# Will results in the colour of the well

# To get text or fill, generate a 96 long vector filling the plate by row from top left.
ex1 <- rep("exp1", 4)
ex2 <- rep("exp2", 4)
ex3 <- rep("exp3", 4)
coating <- rep(c(ex1,ex2,ex3),8)


raw_text <- expand.grid(LETTERS[1:8], 1:12) 
as_text <- paste0(raw_text$Var1,raw_text$Var2)
text <- matrix(as_text, )

t <- mutate(t, coating = as.factor(coating), text)



