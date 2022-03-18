library(data.table)
library(ggplot2)
library(dplyr)
library(colorspace)
library(ggeasy)

#read the data downloaded from Sci-hub on 17.03.2022
sci_hub_data <- read.table("2022-03-17.tab", header = F, sep = "\t", fill = TRUE)
colnames(sci_hub_data) <- c('Countries','Number_of_Downloads') #add column names
View(sci_hub_data) #view the final data

length(sci_hub_data$Countries) #determine number of countries
as.numeric(sci_hub_data$Number_of_Downloads) #make the column numeric


sci_hub_data1 <- sci_hub_data %>% #filter the data
  filter(Number_of_Downloads >= 500000)

sci_hub_data2 <- sci_hub_data1%>%
  group_by(desc(Number_of_Downloads))

View(sci_hub_data2)


#Create a barplot

plot <- ggplot(sci_hub_data2, aes(x= reorder(Countries,Number_of_Downloads), 
                          y= Number_of_Downloads,
                          fill=factor(ifelse(Countries=="Turkey","Highlighted","Normal")))) +
  geom_bar(stat="identity", alpha=.6, width=0.6, show.legend = FALSE) +
  scale_fill_manual(values=c("red","#772F67")) +
  theme_bw(base_size = 30) +
  coord_flip()+
  theme_bw()

plot1 <- plot + theme(
  plot.title = element_text(color="black", size=12, face="bold"),
  axis.title.x = element_text(color="black", size=12, face="bold"),
  axis.title.y = element_text(color="black", size=12, face="bold"),
  panel.border     = element_blank(),
  axis.line        = element_line(colour = "black"),
  panel.grid.major = element_line(),
  panel.grid.major.x = element_blank(),
  panel.grid.major.y = element_blank(),
  panel.grid.minor = element_blank(),
  panel.grid.minor.x = element_blank(),
  panel.grid.minor.y = element_blank(),
  strip.background = element_rect(colour = "black", size = 0.5),
  legend.key       = element_blank(),
  axis.text.y = element_text(size = 10, color = 'black', family = 'Arial', face = 'bold', vjust = 0.3),
  axis.text.x = element_text(size = 10, color = 'black', family = 'Arial', face = 'bold', vjust = 0.3)
  )
plot2 <- plot1 +ggtitle("Sci-Hub Downloads") +
  ggeasy::easy_center_title()+ #center the plot title with ggeasy package
  xlab("Countries") + ylab("Number of Paper Downloads from Sci-Hub")  

#Stop showing abbreviated labels (1e+ 07 numbers) in the axis
plot2 + scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

###################################################################
#Alternative barplot 
barplot(sci_hub_data2$Number_of_Downloads, names=sci_hub_data2$Countries, 
        col=rgb(0.8,0.1,0.1,0.6),
        xlab="Countries", 
        ylab="Number of Paper Downloads from Sci-Hub", ylim = c(50000, 35000000),
        main="Sci-Hub Downloads", 
        space=0.5)+
  theme(axis.text.x =element_text(angle = 90, size = 10))

#plot with red lines
plot +theme_minimal()+
  theme(panel.grid = element_line(colour = "red"), 
        panel.grid.major = NULL,
        panel.grid.minor = NULL)
