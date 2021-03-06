## This function create a special object 
##that stores a matrix and caches its inverse matrix

##The first function, `makeCacheMatrix` creates a special "matrix", which is
##really a list containing a function to
#1.  set the value of the matrix
#2.  get the value of the matrix
#3.  set the value of the inverse matrix
#4.  get the value of the inverse matrix.

#Information about inverse matrix
#https://cran.r-project.org/web/packages/matlib/vignettes/inv-ex1.html


makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) m <<- inverse
  getinverse<- function() m
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}

## The following function calculates the inverse of the special "matrix"
## first checks to see if the inverse matrix has already been calculated.
## If so, it `get`s the matrix from the cache and skips the computation. 
# Otherwise, it calculates the mean of the data and sets the value of the
#mean in the cache via the `setmean`function.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  
  m <- x$getinverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}

### Testing functions

## a normal matrix
A <- matrix( c(5, 1, 0,
               3,-1, 2,
               4, 0,-1), nrow=3, byrow=TRUE)

A_1<-makeCacheMatrix(A)

## the solution is a identity matrix
A %*% cacheSolve(A_1)

