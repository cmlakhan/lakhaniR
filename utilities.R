# Title     : R utility functions
# Created by: chirag
# Created on: 11/22/19


cor_spearman_train <- function(x, data) {
  cor(data[,x[1] ], data[,x[2]],method = 'spearman', use = 'pairwise.complete.obs')
}



run_correlation_df <- function(df,listVariables,numCores){
  pairs <- combn(ncol(df), 2, simplify=F)

  cols_names_train <- data.frame(variable=names(df)) %>%
    rownames_to_column('id') %>%
    mutate(id=as.numeric(id))


  out <- mclapply(pairs, cor_spearman_train,mc.cores = numCores)

  cor_train_list <- cbind(do.call(rbind, pairs), unlist(out)) %>%
    data.frame(.) %>%
    select(var1=X1,var2=X2,correlation_value=X3) %>%
    inner_join(.,cols_names_train, by=c('var1'='id')) %>%
    inner_join(.,cols_names_train, by=c('var2'='id')) %>%
    rename(variable1=variable.x, variable2=variable.y, Field1=Field.x,
           Field2=Field.y)

  return(cor_train_list)


}

