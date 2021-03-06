## This R script contains one function: cacheSolve
## The prupose of this is to cache computationally intensive inverses for
## any possible future use.

## cacheSolve computes the inverse ofa matrix. If the inverse has already been calculated and the 
## matrix has not changed, then it will retrieve the inverse from the cache

## There is no makeCacheMatrix function present as I found it to be unnecessary

cacheSolve <- function(x) 
{
  # Create matrix_cache if one does not exits
  if (!exists("matrix_cache"))
  {
    # Needs to be created in the global environment, hence the '<<-'
    matrix_cache <<- list()
  }
  
  # This part looks into the matrix_cache list to find the matrix in
  # question, and return the ith + 1 value which corresponds to the
  # inverse
  if (list(x) %in% matrix_cache)
  {
    for (i in 1:length(matrix_cache))
    {
      if (matrix_cache[i] %in% list(x))
      {
        message("Found it!!")
        return(matrix_cache[i+1])
        break
      }
      
    }
  }
  # Need to make sure the matrix is invertible
  if (det(x) != 0)
  {
    message("Computing inverse..")
    matrix_inverse <- solve(x)
    temp_cache <- c(list(x), list(matrix_inverse))
    matrix_cache <<- c(matrix_cache, temp_cache)
    return(matrix_inverse)
  }
  
  # Let the user know if the matrix is not invertible
  if (det(x) == 0)
  {
    message("That matrix is not invertible")
  }
}
