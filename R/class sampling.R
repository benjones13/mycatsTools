library(openxlsx)

MyCATS_ClassSampler = function(file_in, file_out, seed = NULL){
  if(substr(file_in, nchar(filepath_in)-4, nchar(filepath)) != ".xlsx"){
    stop("Filepath in must end in .xlsx")
  }
  if(substr(file_out, nchar(filepath_in)-4, nchar(filepath)) != ".xlsx"){
    stop("Filepath out must end in .xlsx")
  }
  if(is.null(seed)){stop("Please use the seed argument to set the seed to ensure reproducibility")}
  
  classlist = openxlsx::read.xlsx(file_in)
  
  classlist_sampled = data.frame(School.ID = rep(unique(classlist$School.ID), each = 6),
                                 Class.ID = rep(NA, length(unique(classlist$School.ID)) * 6 ),
                                 Class.name = rep(NA, length(unique(classlist$School.ID)) * 6),
                                 Year.group = rep(NA, length(unique(classlist$School.ID)) * 6))
  for(i in unique(classlist$School.ID)){
    print(i)
    recep.classes = sample(classlist$Class.ID[classlist$School.ID == i & classlist$Year.group == "reception"], 2)
    yr1.classes = sample(classlist$Class.ID[classlist$School.ID == i & classlist$Year.group == "year 1"], 2)
    yr2.classes = sample(classlist$Class.ID[classlist$School.ID == i & classlist$Year.group == "year 2"], 2)
    classlist_sampled[classlist_sampled$School.ID == i,c("Class.ID", "Class.name", "Year.group")] = classlist[classlist$School.ID == i & classlist$Class.ID %in% c(recep.classes, yr1.classes, yr2.classes),
                                                                                                              c("Class.ID","Class.name","Year.group")]
    rm(recep.classes, yr1.classes, yr2.classes)
    
  }
  openxlsx::write.xlsx(classlist_sampled, file_out)
}

MyCATS_ClassSampler("")