#' This is s small function the split the data according to thier types (numerica, integers or factors)
#' @param Data is the dataframe we are spliting it's variables to different classes.
#' @return return a list that each element contain the coloumns that belong to specific class
#' @details This function split the data to different classes depending on the data type that is contained in each variable in the data
#' @author Rani Basna
#' @export
Data_Classes_Split<- function(Data){
  # checking the data format
  if (!is.data.frame(Data)){
    stop("The data is not in dataframe format")
  }
  # spliting the data
  Airway_spilts <- split(names(Data),sapply(Data, function(x) paste(class(x), collapse=" ")))
  return(Airway_spilts)
}
