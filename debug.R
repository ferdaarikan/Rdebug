
log<-function(arg){
  obj_exists = exists("diagnosticsEnv", where = .GlobalEnv) 
  if(!obj_exists)  {
    diagnosticsEnv <-new.env(parent = .GlobalEnv)
    assign("diagnosticsEnv", diagnosticsEnv, envir = .GlobalEnv)
    assign("data", as.data.frame(c()), envir = diagnosticsEnv)   
  }
  
  diagnosticsEnv <- get("diagnosticsEnv")  
  fcn_name = as.character( sys.call(-1))[1]
  var_name = deparse(substitute(arg))
  cmd = paste("data[", fcn_name , ",", var_name, "]", sep="")
  
  local_diag = get("data", envir = diagnosticsEnv)
  local_diag[fcn_name, var_name] = arg
  assign("data", local_diag, envir = diagnosticsEnv)
  msg = paste(fcn_name, "(", var_name, "): ", arg , sep="" )
  print(msg)
}
