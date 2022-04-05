**Welcome to Code Club**

We launched a weekly Code Club in the lab since it is crucial for trainees to gain skills to display their data and do statistical analysis.

This is an R-focused coding club, and we will introduce data manipulations and data visualization to participants in the Code club. We will explain the many forms of data (Numeric, Integers, Complex, Logical, and Characters) as well as how to construct a data structure or read a file (read.delim, read.csv, fread, read.table etc). Participants will be shown a variety of data manipulation functions such as filter(), distinct(), arrange(), select(), rename(), mutate() and transmutate(), inner_join (), left_join(), and so on.


We'll demonstrate to participants in the Code club how to use ggplot and heatmap to create customized bar plots and heatmaps. Bar charts are a popular visualization tool for displaying categorical variables with numbers. Each category variable is depicted as a bar based on the data associated with it. 


Generate a heatmap with single-cell RNA-seq data (filtered). Following the installation of the required packages, using the library(name of package) function, each package can be loaded into RStudio and used.

**Load the following packages**


```
library(data.table)
library(dplyr)
library(pheatmap)
library(RColorBrewer)

```


**Read the csv file**

```
df<-fread("./Single_cell_paper_master/data/C_elegans_single_cell.csv")
```

**Rename the column name that would cause us problems in the next steps.**

```
df <- rename(df, Intestinal_rectal_muscle = `Intestinal/rectal_muscle`) #rename the colunm name

colnames(df)[22]<-"flp_1_interneurons" 
colnames(df)
```


**Filter data**

```
muscle <- df %>%
  filter_all(all_vars(. > 15))%>%
  dplyr::filter(Body_wall_muscle > 250 & Intestinal_rectal_muscle> 250)%>%
  na.omit() %>% #Omit if there NA
  relocate(Body_wall_muscle, .after = Intestine) %>% #carry the Body_wall_muscle after intestine
  relocate(Intestinal_rectal_muscle, .after = Intestine)#carry the intestinal_rectal_muscle after intestine
```


**Remove the first column name in a data frame and convert dataframe to a matrix**

```
muscle <-muscle[,-1] #remove the first column
muscle1<-muscle[,-1] #remove the first column
muscle_new <-as.matrix(muscle1) #make a matrix for heatmap
rownames(muscle_new)<-muscle$symbol #add gene names
```
**Make annotations  for column names and assign colors to them**

```
mypalette<-brewer.pal(7,"Blues")

annotcolor <-data.frame("Cell types" = factor(rep(c("Non-Muscle cells", "Muscle cells"), c(25, 2))))
colnames(annotcolor)<-"Cell types"
rownames(annotcolor)<-colnames(muscle_new)


annot_color <-list(
  `Cell types` = c(`Non-Muscle cells` = "deepskyblue", `Muscle cells` = "coral3")
)
```

**Generate the heatmap** 

```
pheatmap(muscle_new, cluster_cols = FALSE, cluster_rows = FALSE, show_rownames = TRUE, 
         fontsize_row = 7, scale = "row", angle_col = 315, 
         annotation_col = annotcolor, annotation_names_row = FALSE, 
         annotation_names_col = FALSE,
         annotation_colors = annot_color)
```

![Rplot](https://user-images.githubusercontent.com/12661265/161766453-9479db47-1a30-4008-98c9-e23adb5a9826.png)



**Animations created with gganimate display a number of SARS-CoV-2 genomic RNA sequences (2021) submitted to NCBI by countries.**

![covid-19_variant](https://user-images.githubusercontent.com/12661265/160349923-d7bd0deb-69e4-4545-a5b5-163c969e03d0.gif)


**An example customized plot from the Code Club is shown below**

The original data required to create the customized barplot was retrieved from Sci-Hub on 17.03.2022. We used read.table to read the file and manipulate the data using filter() and group_by. We next utilized ggplot to generate a customized barplot. 


![Turkey_downloads](https://user-images.githubusercontent.com/12661265/158946046-d4e025b5-5a24-4bc0-a965-6dcbcf1df47f.png)






