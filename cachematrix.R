#  makeCacheMatrix
#
#  Create a cacheMatrix object, which stores a matrix, and also can be used to calculate
#  and store the inverse of that matrix
#
#  Returns the cacheMatrix object created.
#
#  Inputs:
#  x   -  A matrix to be used as the initial matrix of this object. Default is an empty matrix.
#
#  Member functions:
#  set(y)      -  Set the matrix to y. Clears the previous cached inverse value.
#  get         -  Accessor function that returns the matrix
#  setinv(inv) -  Set the inverse of the matrix to z.
#                 Note: there are no checks if z is the correct inverse of the matrix
#  getinv      -  Accessor function that returns the cached inverse of the matrix if already calculate,
#                 or calculates the inverse of the matrix first before returning if not yet calculated,
#                    after which it is cached.
makeCacheMatrix <- function(x = matrix()) {
   # Initialise an empty matrix to hold the inverse of this matrix 
   x_inv <- NULL
   
   # Now define the member functions of the cacheMatrix object
   
   # 
   set <- function(y) {
      # Use <<- so 
      x     <<- y
      # Clear
      x_inv <<- NULL
   }
   # Return the matrix itself
   get <- function() x
   setinv <- function(inv) x_inv <<- inv
   # Return the stored matrix inverse, even if it's still null
   getinv <- function() x_inv
   
   # Return the cacheMatrix object, as a list containing references to the member methods
   list(set = set, get = get,
        setinv = setinv,
        getinv = getinv)
}

# cacheSolve
#
# Solves the inverse of a matrix in a cacheMatrix object.
# Will load the cached result if available, instead of calculating again.
#
# Returns the inverse matrix
#
# x         -  cacheMatrix object to pass in and solve
# msg_ena   -  If TRUE, will print debug messages (default=TRUE)
cacheSolve <- function(x, msg_ena=TRUE, ...) {
   # Get the inverse stored in the cacheMatrix object.
   x_inv <- x$getinv()
   # If the inverse is not null, it exists and has already bee calculated and cached.
   # Simply return the cached value
   if(!is.null(x_inv)) {
      # Print debug message if wanted
      if(msg_ena==TRUE) {
         message("Getting cached inverse for the matrix")
      }
      return(x_inv)
   }
   # If the inverse does not yet exist (x_inv==null), calculate it here
   # Get the matrix
   data <- x$get()
   # Calculate the matrix inverse and store in x_inv
   x_inv <- solve(data, ...)
   # Cache the matrix inverse in the cacheMatrix object
   x$setinv(x_inv)
   # Return the calculated matrix inverse
   x_inv
}
