**Welcome to Code Club**

We launched a weekly Code Club in the lab since it is crucial for trainees to gain skills to display their data and do statistical analysis.

This is an R-focused coding club, and we will introduce data manipulations and data visualization to participants in the Code club. We will explain the many forms of data (Numeric, Integers, Complex, Logical, and Characters) as well as how to construct a data structure or read a file (read.delim, read.csv, fread, read.table etc). Participants will be shown a variety of data manipulation functions such as filter(), distinct(), arrange(), select(), rename(), mutate() and transmutate(), inner_join (), left_join(), and so on.


We'll demonstrate to participants in the Code club how to use ggplot and heatmap to create customized bar plots and heatmaps. Bar charts are a popular visualization tool for displaying categorical variables with numbers. Each category variable is depicted as a bar based on the data associated with it. 

**Generate a heatmap with single-cell RNA-seq data (filtered).**

Following the installation of the required packages, using the library(name of package) function, each package can be loaded into RStudio and used.

**Load the following packages**


```
library(data.table)
library(dplyr)
library(pheatmap)
library(RColorBrewer)
```


**Read the csv file**

```
df<-fread("./Single_cell_paper/data/C_elegans_single_cell.csv")
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







**Use of stringr package** 

```
# Create a data frame
data_subset <- data.frame(
  AA1 = c("R2A", "R2K", "E3A", "I4V", "V4L", "I5F", "I5L", "S6I", "H8Y", "V9M", "A12V", "S12A", "V14I"),
  AA3 = c("Arg2Ala", "Arg2Lys", "Glu3Ala", "Ile4Val", "Val4Leu", "Ile5Phe", "Ile5Leu", "Ser6Ile", "His8Tyr", "Val9Met", "Ala12Val", "Ser12Ala", "Val14Ile"),
  Tubulin_isoform = c("AAA35180.1", "AEE27747.1 (TUA4)", "AAA35180.1", "NP_001300652.1 (Tuba4a)", "XP_002364807.1 (α1-tubulin)", "NP_035783.1 (Tuba1a)", "NP_001257328.1 (TUBA1A)", "XP_002364807.1 (α1-tubulin)", "XP_002364807.1 (α1-tubulin)", "NP_033472.1 (Tuba3a)", "AEE27747.1 (TUA4)", "NP_001257328.1 (TUBA1A)", "NP_033475.1 (Tuba3b)"),
  Organism = c("S. cerevisiae", "A. thaliana", "S. cerevisiae", "M. musculus", "T. gondii", "M. musculus", "H. sapiens", "T. gondii", "T. gondii", "M. musculus", "A. thaliana", "H. sapiens", "M. musculus")
)
```


**Select the specific columns**

```
library(dplyr)
data_subset_new <- data_subset %>% 
  select("AA1" ,"AA3", "Tubulin_isoform",  "Organism")
```


**Visualize the data**

```
> data_subset
    AA1      AA3             Tubulin_isoform      Organism
1   R2A  Arg2Ala                  AAA35180.1 S. cerevisiae
2   R2K  Arg2Lys           AEE27747.1 (TUA4)   A. thaliana
3   E3A  Glu3Ala                  AAA35180.1 S. cerevisiae
4   I4V  Ile4Val     NP_001300652.1 (Tuba4a)   M. musculus
5   V4L  Val4Leu XP_002364807.1 (α1-tubulin)     T. gondii
6   I5F  Ile5Phe        NP_035783.1 (Tuba1a)   M. musculus
7   I5L  Ile5Leu     NP_001257328.1 (TUBA1A)    H. sapiens
8   S6I  Ser6Ile XP_002364807.1 (α1-tubulin)     T. gondii
9   H8Y  His8Tyr XP_002364807.1 (α1-tubulin)     T. gondii
10  V9M  Val9Met        NP_033472.1 (Tuba3a)   M. musculus
11 A12V Ala12Val           AEE27747.1 (TUA4)   A. thaliana
12 S12A Ser12Ala     NP_001257328.1 (TUBA1A)    H. sapiens
13 V14I Val14Ile        NP_033475.1 (Tuba3b)   M. musculus
```


**Split the AA1 column into three different columns**

```
> library(stringr)
data_subset_new_splt <- data_subset_new %>%
  mutate(Original = str_extract(AA1, "[A-Z]"),
         Position = as.numeric(str_extract(AA1, "\\d+")),
         Change = str_match(AA1, "[A-Z]"))
#View the rearranged data
data_subset_new_splt
```


```
> data_subset_new_splt
    AA1      AA3             Tubulin_isoform      Organism Original Position Change
1   R2A  Arg2Ala                  AAA35180.1 S. cerevisiae        R        2      R
2   R2K  Arg2Lys           AEE27747.1 (TUA4)   A. thaliana        R        2      R
3   E3A  Glu3Ala                  AAA35180.1 S. cerevisiae        E        3      E
4   I4V  Ile4Val     NP_001300652.1 (Tuba4a)   M. musculus        I        4      I
5   V4L  Val4Leu XP_002364807.1 (α1-tubulin)     T. gondii        V        4      V
6   I5F  Ile5Phe        NP_035783.1 (Tuba1a)   M. musculus        I        5      I
7   I5L  Ile5Leu     NP_001257328.1 (TUBA1A)    H. sapiens        I        5      I
8   S6I  Ser6Ile XP_002364807.1 (α1-tubulin)     T. gondii        S        6      S
9   H8Y  His8Tyr XP_002364807.1 (α1-tubulin)     T. gondii        H        8      H
10  V9M  Val9Met        NP_033472.1 (Tuba3a)   M. musculus        V        9      V
11 A12V Ala12Val           AEE27747.1 (TUA4)   A. thaliana        A       12      A
12 S12A Ser12Ala     NP_001257328.1 (TUBA1A)    H. sapiens        S       12      S
13 V14I Val14Ile        NP_033475.1 (Tuba3b)   M. musculus        V       14      V
```

**Filter rows for the desired organisms** 

```
library(dplyr)
df_new_filtered <- data_subset_new_splt %>%
  filter(Organism %in% c("S. cerevisiae", "H. sapiens", "M. musculus"))
>df_new_filtered
   AA1      AA3         Tubulin_isoform      Organism Original Position Change
1  R2A  Arg2Ala              AAA35180.1 S. cerevisiae        R        2      R
2  E3A  Glu3Ala              AAA35180.1 S. cerevisiae        E        3      E
3  I4V  Ile4Val NP_001300652.1 (Tuba4a)   M. musculus        I        4      I
4  I5F  Ile5Phe    NP_035783.1 (Tuba1a)   M. musculus        I        5      I
5  I5L  Ile5Leu NP_001257328.1 (TUBA1A)    H. sapiens        I        5      I
6  V9M  Val9Met    NP_033472.1 (Tuba3a)   M. musculus        V        9      V
7 S12A Ser12Ala NP_001257328.1 (TUBA1A)    H. sapiens        S       12      S
8 V14I Val14Ile    NP_033475.1 (Tuba3b)   M. musculus        V       14      V
> 
```
