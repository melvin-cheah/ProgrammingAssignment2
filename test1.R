# Test simple functionality of cacheMatrix.R functions
# and benchmark caching performance


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
# Calculate its matrix manually - the expected solution
a_inv = matrix(c(-2,3,3,-4),nrow=2,ncol=2)
# Create cacheMatrix object
b = makeCacheMatrix(a)

message("=======================================================")
message("Calculating first time")

# Calculate the inverse using cacheMatrixSolve for the first time
b_inv = cacheSolve(b)

message("Expected inverse is:")
write(a_inv, stdout())
message("Got:")
write(b_inv, stdout())

# Check that solution is correct
all.equal(a_inv, b_inv)

message("=======================================================")
message("Using cached value")

# Get the cached value out
b_inv = cacheSolve(b)

message("Expected inverse is:")
write(a_inv, stdout())
message("Got:")
write(b_inv, stdout())

# Check that solution is correct
all.equal(a_inv, b_inv)

message("=======================================================")
message("Do some benchmarking")
c = makeCacheMatrix(a)
bm_text = bm(cacheSolve(c), times = 1)
message("First time calculate")
print(bm_text)
bm_text
message("Using cached value")
bm_text = bm(cacheSolve(c, msg_ena=FALSE), times = 5)
print(bm_text)
