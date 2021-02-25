MyCATS_Randomiser = function(seed){
  set.seed(seed)
  batch = menu(c("1st","2nd","3rd"), title = "Which batch of schools are we randomising?")
  if(batch == 1){
    batch1_filepath = readline(prompt = "Please enter the CSV filepath for the first batch of schools: ")
    print(batch1_filepath)
  }
}
MyCATS_Randomiser(seed = 78610)
