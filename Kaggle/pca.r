library(ggplot2); library(dplyr); library(readr)

# Here we will be trying to use PCA for EDA purposes and try to find out the
# most important features aka the features with the most variation

# read in the data

clean <- read_csv('train_cleaned.csv')
my_data <- subset(clean, select = -c(SalePrice, X1))
colnames(my_data)

# splitting the data into test and train

## 75% of the sample size
smp_size <- floor(0.70 * nrow(my_data))

## set the seed to make your partition reproductible
set.seed(123)
train_ind <- sample(seq_len(nrow(my_data)), size = smp_size)

train <- my_data[train_ind, ]
test <- my_data[-train_ind, ]

prin_comp <- prcomp(my_data, scale. = TRUE)

names(prin_comp)

prin_comp$rotation
dim(prin_comp$x)

biplot(prin_comp, scale = 0)

#proportion of variance explained
std_dev <- prin_comp$sdev
pr_var <- std_dev^2

prop_varex <- pr_var/sum(pr_var)
prop_varex[1:20]

#scree plot
plot(prop_varex, xlab = "Principal Component",
       ylab = "Proportion of Variance Explained",
       type = "b", xlim = c(0,10))

#cumulative scree plot
plot(cumsum(prop_varex), xlab = "Principal Component",
       ylab = "Cumulative Proportion of Variance Explained",
       type = "b", xlim = c(0,90))



# Retain the first 90 Principal componenets
eigenvectors <- prin_comp$rotation[, 1:90]
eigenvectors_df <- as.data.frame(eigenvectors)
eigenvectors_df = cbind(features = rownames(eigenvectors_df), eigenvectors_df)
eigenvectors_df$features = as.character(eigenvectors_df$features)

# getting the most important features

imp_featrs <- vector(length = 90, mode = "character")
for (i in 2:90){
  imp_featrs[i] <- eigenvectors_df %>%
    filter(abs(eigenvectors_df[,i]) == max(abs(eigenvectors_df[,i]))) %>%
    select(features)


}

imp_featrs <- unlist(imp_featrs)
