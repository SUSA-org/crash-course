library(ggplot2); library(dplyr)

num_featrs <- c('LotFrontage', 'LotArea' ,'YearBuilt', 'YearRemodAdd',
                'MasVnrArea','BsmtFinSF1','BsmtUnfSF', 'TotalBsmtSF','1stFlrSF',
                '2ndFlrSF','GrLivArea',
                'TotRmsAbvGrd','GarageArea', 'WoodDeckSF', 'OpenPorchSF',
                'EnclosedPorch','PoolArea','MiscValue')

y <- select(poly_data, 'SalePrice')
scatter_plots <- function(df, feat) {
  df  %>% 
    ggplot(aes(feat, df$SalePrice)) + facet_wrap(~ feat, scales = "free") + 
    theme(legend.position = "none") + labs(x = "", y = "")
}

box_plots <- function(df) {
  
}