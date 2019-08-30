# Hello, Tecan!
#
# This is an example function named 'read_tecan'
# which reads Tecan Magellan Spec Data'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
#   read_tecan is a function for reading od tecan spec data files
read_tecan = function(file){

  # filename = readr::read_lines(file,n_max = 1)
  # wells = readr::read_lines(file,skip = 3,n_max=1)
  # annot = readr::read_lines(file,skip = 4,n_max=1)
  y = utils::read.delim(file,stringsAsFactors = F,check.names = F, header = F)
  ncoln = ncol(y)
  wells = paste0(rep(LETTERS[1:8],each = 12),rep(1:12,8))
  nch = nchar(wells)
  wnch = which(nch==2)
  wells[wnch] = paste0(rep(LETTERS[1:8],each = 9),0,rep(1:9,8))
  names(y) = c("runtime",wells)
  y$runtime = gsub("s","",y$runtime)
  y$runtime = as.numeric(y$runtime)
  #y$runtime = round(y$runtime/3600,2)
  my = reshape2::melt(y,id.vars = "runtime",value.name = "measure",variable.name = "well")
  my$plate = 0
  my$well = as.character(my$well)
  my = my[,c("plate", "well",  "runtime", "measure")]
  my
}
