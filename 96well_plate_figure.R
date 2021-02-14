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
ex1 <- rep("example1", 4)
ex2 <- rep("example2", 4)
ex3 <- rep("example3", 4)
coating <- rep(c(ex1,ex2,ex3),8) #This example used a simple repeating pattern.


raw_text <- expand.grid(LETTERS[1:8], 1:12) 
as_text <- paste0(raw_text$Var1,raw_text$Var2)
text <- unlist(as.data.frame(t(matrix(as_text, nrow = 8))), use.names = FALSE)
# This example uses generates a matrix, transposed and unlists it to generate the correct order

t <- mutate(t, coating = as.factor(coating), text)
# Generates the final dataframe containing all infomation to generate plot

# This ensures the correct dimentions of the plate.
ratio <- 0.5
ywall = c(min(y)-ratio,max(y)+ratio)
xwall = c(min(x)-ratio,max(x)+ratio)

fig <- t %>% ggplot(aes(x,y))+
  geom_point(size = 10,shape = 1, col = "black")+
  geom_point(size=9.5, alpha = 0.3, aes(col = coating))+
  geom_text(aes(label = text), size = 3)+
  coord_fixed(ratio = 8/12)+
  geom_segment(aes(x=xwall[1],xend=xwall[2],y=xwall[1],yend=xwall[1]))+
  geom_segment(aes(x=xwall[1],xend=xwall[2],y=8.75,yend=8.75))+
  geom_segment(aes(y=xwall[1],yend=8.75,x=xwall[1],xend=xwall[1]))+
  geom_segment(aes(y=xwall[1],yend=8.75,x=xwall[2],xend=xwall[2]))+
  theme_void()

ggsave("96_well_fig.pdf", plot = fig, device = "pdf", height = 4,width = 6, units = "in")
