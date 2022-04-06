library(rvest)
library(dplyr)
library(readr)

#read csv file
humangenes <- read_csv("/Users/oktay/Desktop/human_proteins.csv")
View(humangenes)
colnames(humangenes)

humangenes1 <- humangenes %>%
  dplyr::select(Locus)%>%
  unique()

allgenes <- humangenes1$Locus

pubmed_data <- data.frame()

for(i in allgenes){
  link <- paste0("https://pubmed.ncbi.nlm.nih.gov/?term=", i,"&sort=date")
  page <- read_html(link)
  gene_name <- i 
  number <- page %>% html_nodes("span.value") %>% html_text()
  pubmed_data<- if(length(number) > 0)  {rbind(pubmed_data, data.frame(gene_name, number, stringsAsFactors = FALSE)) }
}

View(pubmed_data)