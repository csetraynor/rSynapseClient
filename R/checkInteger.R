## return an boolean indicating whether the passed object is an integer.
## 
## Author: Matthew D. Furia <matt.furia@sagebase.org>
###############################################################################

checkInteger <- function(x){
  result <- NULL
  if(length(x) == 0L)
    return(FALSE)
  for(i in 1:length(x)){
    if(length(x) > 1){
      xx <- x[[i]]
    }else{
      xx <- x
    }
    if(any(isS4(xx)) | length(xx) == 0L | is.list(xx) | is.character(xx)){
      result <- c(result, FALSE)
    }else{
      suppressWarnings(thisVal <- tryCatch({
            xx <- gsub("L$","",xx) # Remove trailing 'L'
            .Machine$double.eps > abs(as.integer(xx) - as.numeric(xx))
          },
          error = function(e) { rep(FALSE, length(xx)) }
        )
      )
      mk <- is.na(thisVal) | is.null(thisVal)
      if(any(mk)) {
        thisVal[mk] <- FALSE
      }
      if (class(try(as.character(xx), silent=TRUE)) != "try-error") {
          # as.integer() and as.numeric() may interpret a string as '0'
          xx <- gsub("^-","",xx) # Remove leading '-'
          if (regexpr('\\D', xx) >= 0) {
            thisVal <- FALSE
          }
      }
      result <- c(result, thisVal)
    }
  }
  result
}
