#' Title This is small function to output the final data as numerical type
#'
#' @param converted_data insert the converted data from the UFT_func
#' @param original_data insert the full original data
#' @param scale_numeric logical. Scale the data if True inserted. Default is False.
#'
#' @return a data frame the contain the tranformed data
#' @export
#'
#' @examples
#' X <- data.frame("ID" = as.numeric(c(1,2,3,4)), "Age" = c(21,15,44,14), "Sex" = c("Male", "Male", "Female", "Female" ),
#' "Name" = c("John","Samer", "Sara", "Carolina"), Smoking = c("Yes","No", "No","Yes"))
#' uft_x <- UFT_func(Data = X,Seed = 11)
#' bined_data <- bined_converted_func(converted_data = uft_x, original_data = X, scale_numeric = TRUE)
bined_converted_func <-  function(converted_data, original_data, scale_numeric = FALSE){
  if (scale_numeric == TRUE){
    num_data <- original_data %>% select_if(is.double) %>% scale() %>% as.data.frame()
  }
  else{
    num_data <- original_data %>% select_if(is.double)
  }
  converted_df <- cbind(converted_data, num_data)
  assertthat::are_equal(dim(converted_df)[1], dim(original_data)[1])
  assertthat::are_equal(dim(converted_df)[2], dim(original_data)[2])
return(converted_df)
}
