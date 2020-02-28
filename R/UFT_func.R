#' Title Unsupervised Feature Transformation
#'
#' @param Data is the original data we want to deal with. It should be of data fram format. It may contain both categorical and numerical features.
#'      The UFT_Func will split the data and drop the already numerical features.
#' @param Seed is for reproducibility reasons.
#'
#' @return The output from the UFT_Func is a dataframe of numerical columns replacing the original categorical features.
#' @export
#' @import dplyr assertthat
#' @importFrom purrr map
#' @importFrom stats rnorm
#' @examples
#' X <- data.frame("ID" = as.numeric(c(1,2,3,4)), "Age" = c(21,15,44,14), "Sex" = c("Male", "Male", "Female", "Female" ), "Name" = c("John","Samer", "Sara", "Carolina"), Smoking = c("Yes","No", "No","Yes"))
#' uft_x <- UFT_func(Data = X,Seed = 11)
UFT_func <- function(Data, Seed){
  # create a default seed
  set.seed(Seed)
  # checking the data format
  if (!is.data.frame(Data)){
    stop("The Data is not in dataframe format")
  }
  # check for missing data
  assertthat::are_equal(sum(is.na(Data)), 0)
  # Spliting the data according to their classes
  data_splits <- Data_Classes_Split(Data)
  drops_numerical <-data_splits$numeric
  # droping numerical classes
  data_cate <- Data[ , !(names(Data) %in% drops_numerical)]
  data_cate <- Prepare_data(data_cate)
  # check that there are other coloumns than numerical
  assertthat::not_empty(data_cate)
  # count numbre of uniqe values in each column
  coutn_unique_data <- data_cate %>% dplyr::summarise_all(n_distinct)
  # creat a function to compare the number of uniqe element within each column and use it within map func
  com_fun <- function(.x){
    return(.x == 1)
  }
  # using map from purr library to creat a list of true/false values where True refere to column in the data that has a one value
  count_number_logic <- purrr::map(coutn_unique_data,com_fun)
  # check the follwoing condition
  if (TRUE %in% count_number_logic){
    #print(names(count_number_logic[match(TRUE, count_number_logic)]))
    #stop(paste0("The follwoing column in the data has only one value and this need to be removed from the clustering ", names(count_number_logic[match(TRUE, count_number_logic)])))
    stop(paste0(" The follwoing column in the data has only one value and this need to be removed from the clustering: ", names(count_number_logic[which(count_number_logic == TRUE)])))
    #stop("The follwoing column in the data has only one value and this need to be removed from the clustering")
  }
  m <- length(data_cate)
  d <- dim(data_cate)[1]
  #
  for (j in 1:m) {
    n <- length(unique(data_cate[,j]))
    S <- as.vector(as.matrix(dplyr::count(data_cate, data_cate[,j], sort = TRUE)[,1])) # the unique values of variable (we did this some that the order match with count and probabilities)
    C <- as.vector(as.matrix(dplyr::count(data_cate, data_cate[,j], sort = TRUE)[,2])) # the count (number of occurance) of the values in the variable
    P <- C/(d*1) # Probabilities
    for (i in 1:n){
      mu <- 0
      L1 <- 0
      L2 <- 1- sum(P^3)
      L3 <- 0
      for (h in 1:n) {
        H <- P[h]*P[i]*(h-i)^2
        L3 <- H + L3
      }
      for (k in 1:i){
        mu1 <- sum((n-k) * P[k])
        L1 <- L1 + mu1
      }
      mu <- ((n -i) - L1) * sqrt(L2/L3)
      for (l in 1:d){
        if (data_cate[l,j] == S[i]){
          data_cate[l,j] <- rnorm(1,mu, P[i])
        }
      }
    }
  }
  return(data_cate)
}
#UFT_func(Data = X, Seed = 11)
