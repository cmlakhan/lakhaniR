# Title     : R utility functions
# Created by: chirag
# Created on: 11/22/19





run_correlation_df <- function(df,listVariables,numCores){
  pairs <- combn(ncol(df), 2, simplify=F)

  cols_names_train <- data.frame(variable=names(train_numeric)) %>%
    rownames_to_column('id') %>%
    mutate(id=as.numeric(id))




}

