# Script for analyzing behavioural data (rts) in R
# November 19, 2018
# maran@cbs.mpg.de

## 0 - PRELIMINARY OPERATIONS
rm(list=ls())  # clear
#install.packages("ggplot2")            # In case it is not already installed, install ggplot

library(ggplot2)                        # load ggplot 2
my_data_file = "/home/raid2/maran/The neural basis of merge/Internship_anna/data_analysis/data_input.csv"
my_data_orig = read.csv(my_data_file) #read data from CSV

## 1 - DATA CLEANING

# Remove trials with response times shorter than 50ms and longer than 80ms and trials with incorrect responses
my_data = my_data_orig[my_data_orig$rts > 50 & my_data_orig$rts < 800,]
my_data = my_data[my_data$accuracy ==1,]
#min(my_data$rts)
#max(my_data$rts)

# Create a vector to use to keep only data which for each subj are between mean and -/+ 2 standard deviations
subj_vect = unique(my_data$subj)                # vector with IDs of subjects
all_data_clean_index = logical(length = 0)      # initialize empty vector of logicals to use as index for data cleaning

# Loop over subj
for (subi in subj_vect){
  
  # Select a single subject and calculate mean and sd 
  cur_subj_data = subset(my_data, my_data$subj ==subi )          # select only a single subject
  cur_subj_mean = mean(cur_subj_data$rts)                        # calculate mean
  cur_subj_sdev = sd(cur_subj_data$rts)                          # calculate standard deviation
  
  # Create an index for selecting trials with only resp times between -2 and + 2 standard deviations from the mean
  cur_subj_index = cur_subj_data$rts > cur_subj_mean- 2*cur_subj_sdev & cur_subj_data$rts < cur_subj_mean + 2*cur_subj_sdev

  # Concatenate with index of previous subjects
  all_data_clean_index = c(all_data_clean_index, cur_subj_index);
  
  #cur_subj_clean = subset(cur_subj_data, cur_subj_data$rts > (cur_subj_mean- 2*cur_subj_sdev) & cur_subj_data$rts < (cur_subj_mean + 2*cur_subj_sdev))
}

# Use the index created in order to extract only the clean data (between mean and +/- 2sd for each participant)
if (length(my_data$rts)==length(all_data_clean_index)){            # do this only if vector is the same length as my_data
  my_data_clean = my_data[all_data_clean_index,]
}

## 2 - DATA CHECK AND FACTOR ASSIGNMENT
# Explore the data
head(my_data_clean)
str(my_data_clean)

# Make subj and block factors (currently are numbers/int)
my_data_clean$subj = as.factor(my_data_clean$subj)
my_data_clean$block = as.factor(my_data_clean$block)
my_data_clean$item_type = as.factor(my_data_clean$item_type)
my_data_clean$item_gram = as.factor(my_data_clean$item_gram)



## 3.0 - ANALYSIS WITH FOUR ITEM CONDITIONS (dn, dv, pn, pv) AND BLOCK
# Aggregate data
my_data_item_type <- aggregate(my_data_clean$rts, by = list(my_data_clean$subj, my_data_clean$block, my_data_clean$item_type), FUN = 'mean')
colnames(my_data_item_type) <- c("subj","block","item_type","rts")
my_data_item_type <- my_data_item_type[order(my_data_item_type$subj), ]
head(my_data_item_type)

# Check if aggregate function works. This should match with subj 1, block 1, and dn type average shown in head(my_data_item_type)
dn_1sub_1block = subset(my_data_clean, my_data_clean$subj == 1 & my_data_clean$block == 1 & my_data_clean$item_type == "dn" ) 
mean(dn_1sub_1block$rts)

# Run anova (factors = block, grammaticality)
my_anova_item_type = aov(rts ~ block + item_type + item_type:block, data = my_data_item_type)
summary(my_anova_item_type)

# Plot results
qplot(item_type, rts, data= my_data_clean  , facets= ~block, main="Response times analysis",xlab="Block", ylab="Rts") + geom_boxplot(aes(fill = item_type))



## 3.1 ANALYSIS WITH GRAMMATICALITY (correct or incorrect) AND BLOCK
# Aggregate data 
my_data_gram <- aggregate(my_data_clean$rts, by = list(my_data_clean$subj, my_data_clean$block, my_data_clean$item_gram), FUN = 'mean')
colnames(my_data_gram) <- c("subj","block","item_gram","rts")
my_data_gram <- my_data_gram[order(my_data_gram$subj), ]
head(my_data_gram)

# Run anova
my_anova_gram = aov(rts ~ block + item_gram + item_gram:block, data = my_data_gram)
summary(my_anova_gram)
        
# Plot results
qplot(item_gram, rts, data= my_data_gram  , facets=~block, main="Response times analysis",xlab="Block", ylab="Rts") + geom_boxplot(aes(fill = item_gram))



### 3. ANALYSIS WITH PHRASE TYPE (DP/VP), AND CORRECTNESS
# Aggregate data 
my_data_phrase_no_block <- aggregate(my_data_clean$rts,by = list(my_data_clean$subj, my_data_clean$phrase_type, my_data_clean$item_gram), FUN = 'mean')
colnames(my_data_phrase_no_block) <- c("subj","phrase_type","item_gram","rts")
my_data_phrase_no_block <- my_data_phrase_no_block[order(my_data_phrase_no_block$subj), ]
head(my_data_phrase_no_block)

# Run anova
my_anova_phrase_no_block = aov(rts ~ item_gram + phrase_type + item_gram:phrase_type, data = my_data_phrase_no_block)
summary(my_anova_phrase_no_block)

# Plot results
qplot(phrase_type, rts, data= my_data_phrase_no_block, xlab="Phrase type", ylab="Rts") + geom_boxplot(aes(fill = item_gram))  + ggtitle("Response times NO block") +   theme(plot.title = element_text(hjust = 0.5))



### 4. ANALYSIS WITH PHRASE TYPE (DP/VP), CORRECTNESS AND BLOCK
# Aggregate data 
my_data_phrase <- aggregate(my_data_clean$rts,by = list(my_data_clean$subj, my_data_clean$block,my_data_clean$phrase_type, my_data_clean$item_gram), FUN = 'mean')
colnames(my_data_phrase) <- c("subj","block","phrase_type","item_gram","rts")
my_data_phrase <- my_data_phrase[order(my_data_phrase$subj), ]
head(my_data_phrase)

# Run anova
my_anova_phrase = aov(rts ~ block + item_gram + phrase_type + item_gram:phrase_type + item_gram:block + phrase_type:block + phrase_type:block:item_gram, data = my_data_phrase)
summary(my_anova_phrase)

# Plot results
qplot(phrase_type, rts, data= my_data_phrase  , facets=~block, xlab="Phrase type", ylab="Rts") + geom_boxplot(aes(fill = item_gram))  + ggtitle("Response times over blocks, phrase type and block") +   theme(plot.title = element_text(hjust = 0.5))


