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