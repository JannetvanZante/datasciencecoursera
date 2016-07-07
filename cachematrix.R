## The two functions below can be used to create a special object that stores a matrix and caches
## its inverse.

## The function makeCacheMAtrix, creates a special "vector" which is really a list containing
## a function to
## 1. set the value of a matrix
## 2. get the value of a matrix
## 3. calculates the inverse of a matrix
## 4. gets the (previously calculated) inverse of a matrix


makeCacheMatrix <- function(x = matrix()) {
  invrs <- NULL
  set <- function(y){
    x <<- y
    invrs <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) invrs <<- inverse
  getinverse <- function() invrs
  list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## The following fucntion calculates the inverse of the special "matrix" created with the above
## function. It first checks whether the inverse has already been calculated. If so, it gets the 
## from the cache. Otherwise, the inverse of  the matrix is calculated and the inverse matrix is set
## in the cache (via the setinverse fucntion)

cacheSolve <- function(x, ...) {
## Return a matrix that is the inverse of 'x'
  invrs <- x$getinverse()
  if (!is.null(invrs)) {
    message("getting cached data")
    return(invrs)
  }
  
  mat <- x$get()
  invrs <- solve(mat,...)
  x$setinverse(invrs)
  invrs
}
