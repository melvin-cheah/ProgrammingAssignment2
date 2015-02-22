# Test that inverse cannot be corrupted when there are more than
# one cacheMatrix object

# Get simple benchmarking if possible
if("microbenchmark" %in% rownames(installed.packages())) {
   library(microbenchmark)
   bm = microbenchmark
} else {
   # If not available, just run whatever it is that needs running
   bm = function(x,...) x
   warning("microbenchmark package not installed, so benchmark results not valid. 
            Run install.packages(\"microbenchmark\").")
}

source("cachematrix.R")
# Create a matrix
a = matrix(c(4,3,3,2),nrow=2,ncol=2)
d= matrix(c(5,4,4,6),nrow=2,ncol=2)
# Calculate its matrix manually - the expected solution
a_inv = matrix(c(-2,3,3,-4),nrow=2,ncol=2)
# Create cacheMatrix objects, make sure they don't corrupt each other's inverse
# due to scoping mess-up
b = makeCacheMatrix(a)
e = makeCacheMatrix(d)

message("=======================================================")
message("Calculating first time")

# Calculate the inverse using cacheMatrixSolve for the first time
b_inv = cacheSolve(b)
e_inv = cacheSolve(e)

message("Expected inverse is:")
write(a_inv, stdout())
message("Got:")
write(b_inv, stdout())
message("Second inverse is:")
write(e_inv, stdout())
