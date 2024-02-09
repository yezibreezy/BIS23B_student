# Read FASTA file and return a vector of contig lengths


readFastaAndGetLengths <- function(fasta_file) {
  lengths <- c() # Initialize vector to store sequence lengths
  current_length <- 0 # Initialize current sequence length
  
  # Open the FASTA file for reading
  con <- file(fasta_file, "r")
  
  while(TRUE) {
    line <- readLines(con, n = 1)
    if(length(line) == 0) { # End of file
      if(current_length > 0) {
        lengths <- c(lengths, current_length)
      }
      break
    }
    if(startsWith(line, ">")) { # Header line
      if(current_length > 0) {
        lengths <- c(lengths, current_length) # Add previous sequence length
      }
      current_length <- 0 # Reset for next sequence
    } else {
      current_length <- current_length + nchar(line) # Add length of the line to current sequence length
    }
  }
  
  close(con) # Close the file connection
  return(data.frame(Contig = seq_along(lengths), Length = lengths))
}