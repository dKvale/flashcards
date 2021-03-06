# Convert table to flash cards
# options Hide answer in 'code' block or 'hover' text.
library(knitr)
library(readr)

tbl_cards <- function(x           = "https://raw.githubusercontent.com/dKvale/japanese/master/greetings.csv",
                      test_col    = 1,
                      ans_col     = 2,
                      title       = "Japanese",
                      order       = "random",
                      ncards      = NA,
                      switch_frx  = 0.5,
                      output      = "markdown") {
  
  
  if(class(x)[1] == "character") x <- read_csv(x)
  
  if(order == "random") {
    x <- x[sample(1:nrow(x), replace = F), ]
  }
  
  if(is.na(ncards) | ncards > nrow(x) | ncards < 1) ncards <- nrow(x)
  
  prez <- paste0(title, "\n=====  \n\n \n\n")
  
  for(n in 1:ncards) {
    
    if(runif(1) < switch_frx) {
      prez <- paste0(prez, "=====  \n", paste0("</br>  \n# [", paste(x[n, test_col], collapse = ", "), "]( '", paste(x[n, ans_col], collapse = ", "), "')   \n\n"))
    } else {
      prez <- paste0(prez, "=====  \n", paste0("</br>  \n# [", paste(x[n, ans_col], collapse = ", "), "]( '", paste(x[n, test_col], collapse = ", "), "')   \n\n"))
    }
  }
  
  #prez <- paste0(prez, '\n <audio src="http://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3" type="audio/mp3" autoplay controls></audio>')
  
  if(output == "html") { return(knit2html(text = prez, options='fragment_only')) }
  
  return(prez)
}