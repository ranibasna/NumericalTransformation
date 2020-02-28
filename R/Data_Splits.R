#' This is s small function the split the data according to thier types (numerica, integers or factors)
#' @param Data is the dataframe we are spliting it's variables to different classes.
#' @return return a list that each element contain the coloumns that belong to specific class
#' @details This function split the data to different classes depending on the data type that is contained in each variable in the data
#' @author Rani Basna
#' @importFrom purrr is_empty
#' @export
#' @examples
#' X <- data.frame("ID" = as.numeric(c(1,2,3,4)), "Age" = c(21,15,44,14), "Sex" = c("Male", "Male", "Female", "Female"),
#' "Name" = c("John","Samer", "Sara", "Carolina"), Smoking = c("Yes","No", "No","Yes"))
#' data_split <- Data_Classes_Split(X)
#'
Data_Classes_Split<- function(Data){
  # checking the data format
  if (!is.data.frame(Data)){
    stop("The data is not in dataframe format")
  }
  if(purrr::is_empty(Data)){
    stop('The data frame is empty')
  }
  # spliting the data
  data_splits <- split(names(Data),sapply(Data, function(x) paste(class(x), collapse=" ")))
  assertthat::assert_that(is.list(data_splits))
  return(data_splits)
}
