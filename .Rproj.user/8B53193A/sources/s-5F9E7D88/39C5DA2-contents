#' Title Prepare the data for the UFT_Func. Mainly, it converts factor type data to integer format.
#'
#' @param categorical_data is the original categorical data that the UFT_Func will transform to become numerical. It should be of data frame format.
#'
#' @return a data frame with all the data are of int type.
#' @export
#'
#' @import dplyr
#' @importFrom  purrr map
#' @examples
#' X <- data.frame("ID" = 1:4, "Sex" = c("Male", "Male", "Female", "Female" ), "Name" = c("John","Samer", "Sara", "Carolina"), Smoking = c("Yes","No", "No","Yes"))
#'Prepare_data(X)

Prepare_data <- function(categorical_data){
  # fa_food_cate <-  sapply(food_cate, as.factor)
  #factor_data <- Original_data %>% select_if(is.factor) %>% mutate_if(is.factor, data.matrix)
  factor_data <- data.matrix(categorical_data %>% dplyr::select_if(is.factor))
  int_data <- categorical_data %>% select_if(is.integer)
  ready_data <- cbind(factor_data, int_data)
  if(FALSE %in% purrr::map(ready_data, is.integer)){
    stop('There are some features that are niether factor nor numeric')
  }
  return(ready_data)
}
