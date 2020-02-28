#' Title Prepare the data for the UFT_Func. Mainly, it converts factor and character type data to integer format.
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
  # converting characterr_data to factor then to integer format
  characterr_data <- categorical_data %>% dplyr::select_if(is.character) %>% mutate_if(is.character, as.factor) %>% data.matrix()
  # converting factor data to integer format
  factor_data <- data.matrix(categorical_data %>% dplyr::select_if(is.factor))
  int_data <- categorical_data %>% select_if(is.integer)
  ready_data <- cbind(factor_data, int_data, characterr_data)
  if(FALSE %in% purrr::map(ready_data, is.integer)){
    stop('There are some features that are niether factor, charechter,nor numeric')
  }
  coutn_unique_data_2 <- ready_data %>% dplyr::summarise_all(n_distinct)
  # creat a function to compare the number of uniqe element within each column and use it within map func
  com_fun_2 <- function(.x){
    return(.x > 10)
  }
  # using map from purr library to creat a list of true/false values where True refere to column in the data that has a one value
  count_number_logic <- purrr::map(coutn_unique_data_2,com_fun_2)
  # check the follwoing condition
  if (TRUE %in% count_number_logic){
    #print(names(count_number_logic[match(TRUE, count_number_logic)]))
    warning(paste0(" The follwoing column in the data has more than 10 uniqe values. Please convert these features to numerical
                   if you do not want to converte them with UFT  ", names(count_number_logic[which(count_number_logic == TRUE)])))
  }
  return(ready_data)
}
# test_pre_data <- Prepare_data(starwars)
# head(test_pre_data)
# coutn_unique_data_test <- test_pre_data %>% dplyr::summarise_all(n_distinct)
# split_startwar <- Data_Classes_Split(starwars)
# split_startwar
# data.matrix(starwars[split_startwar])
# head(purrr::map_df(starwars[split_startwar$character], as.factor))
# head(starwars[split_startwar$character] %>% mutate_if(is.character, as.factor))




