
install.packages("RCurl")
install.packages("rjson")
install.packages("shiny")


library(shiny)
library(RCurl)
library(rjson)

# Accept SSL certificates issued by public Certificate Authorities
#options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

############################################################################################################################
######################### CLASSIFICATION FUNCTION ##########################################################################
############################################################################################################################

http_function_classification  <- function(a,b,c,d,e,f){
  options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
  
  h = basicTextGatherer()
  hdr = basicHeaderGatherer()
  
  
  req = list(
    
    Inputs = list(
      
      
      "input1" = list(
        "ColumnNames" = list("platform", "state", "document_id", "traffic_source", "mean_cf", "ad_id"),
        "Values" = list( list( b,c,d,e,f,a )  )
      )                ),
    GlobalParameters = setNames(fromJSON('{}'), character(0))
  )
  
  body = enc2utf8(toJSON(req))
  api_key = "eFxnePL/Fqqyk4S0eoyqpRtGWr6pphztN+p0nEYc0h2VZSzBCyeWqQvvWOeEiR94Ro2UFqLLcutgKcyJ2tyF5A==" # Replace this with the API key for the web service
  authz_hdr = paste('Bearer', api_key, sep=' ')
  
  h$reset()
  curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/aba4b61d30814babbe06ae6b36e7a3ca/services/e02a47868f2b443484075adcd1c34762/execute?api-version=2.0&details=true",
              httpheader=c('Content-Type' = "application/json", 'Authorization' = authz_hdr),
              postfields=body,
              writefunction = h$update,
              headerfunction = hdr$update,
              verbose = TRUE
  )
  
  headers = hdr$value()
  httpStatus = headers["status"]
  if (httpStatus >= 400)
  {
    print(paste("The request failed with status code:", httpStatus, sep=" "))
    
    # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
    print(headers)
  }
  
  print("Result:")
  result = h$value()

  resultclass <- fromJSON(result)
  resultclass1 <- resultclass$Results$output1$value$Values[[1]][8]
  return(resultclass1)
}


################################################################################################################
########################################### KMEANS #############################################################
################################################################################################################


http_function_KMEANS  <- function(loan_amount_name,dti_name,ai_name,open_acc_name,revol_bal_name,revol_util_name,emp_len_name){
  
  # Accept SSL certificates issued by public Certificate Authorities
  options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
  
  h = basicTextGatherer()
  hdr = basicHeaderGatherer()
  
  
  req = list(
    
    Inputs = list(
      
      
      "input1" = list(
        "ColumnNames" = list("Column 0", "loan_amnt", "term", "int_rate", "installment", "grade", "home_ownership", "annual_inc", "verification_status", "purpose", "addr_state", "emp_length_clean", "dti", "delinq_2yrs", "inq_last_6mths", "open_acc", "revol_bal", "revol_util", "term_1", "grade_1", "home_ownership_1", "verification_status_1", "purpose_1", "addr_state_1"),
        "Values" = list( list( 0, loan_amount_name, 0, 0, 600, NULL, NULL, ai_name, "Verified", NULL, NULL, "0",dti_name , emp_len_name, 15, open_acc_name, revol_bal_name, revol_util_name, 0, 0, 0, 0, 0, 0 ))
      )                ),
    GlobalParameters = setNames(fromJSON('{}'), character(0))
  )
  
  body = enc2utf8(toJSON(req))
  api_key = "mM+TejUgJksVAAkqk0X8Q7wsyAZxPmMWcrYk2qa1zC47qUSnVJoMNEdV0TzGBSZzGTs19GxjdPmqlxsFmmq0/g==" # Replace this with the API key for the web service
  authz_hdr = paste('Bearer', api_key, sep=' ')
  
  h$reset()
  curlPerform(url =  "https://ussouthcentral.services.azureml.net/workspaces/e7e077be891445fb8c7a748c7c7df031/services/ec03e62e4c8c4da284cf96cb2b4ca615/execute?api-version=2.0&details=true",
              httpheader=c('Content-Type' = "application/json", 'Authorization' = authz_hdr),
              postfields=body,
              writefunction = h$update,
              headerfunction = hdr$update,
              verbose = TRUE
  )
  
  headers = hdr$value()
  
  
  
  result = h$value()
  resultpred <- fromJSON(result)
  resultpred1 <- resultpred$Results$output1$value$Values[[1]][25]
  LoanResult1 <- resultpred1
  print("Assigned Cluster:")
  
  if (LoanResult1 == 1)
    LoanResult1 <- "Yes"
  else LoanResult1 <- "No"
  return(LoanResult1)
  #return(resultpred1)
  
  
}

######################################## Prediction after clustering ###################################################


http_function_Cluster_0  <- function(loan_amount_name,dti_name,ai_name,open_acc_name,revol_bal_name,revol_util_name,emp_name){
  
  
  # Accept SSL certificates issued by public Certificate Authorities
  options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
  
  h = basicTextGatherer()
  hdr = basicHeaderGatherer()
  
  
  req = list(
    
    Inputs = list(
      
      "input1" = list(
        "ColumnNames" = list("loan_amnt", "installment", "annual_inc", "emp_length_clean", "dti", "inq_last_6mths", "open_acc", "revol_bal", "revol_util"),
        "Values" = list( list( loan_amount_name, 500, ai_name, emp_name, dti_name, 3,open_acc_name , revol_bal_name, revol_util_name ) )
      )                ),
    GlobalParameters = setNames(fromJSON('{}'), character(0))
  )
  
  
  
  body = enc2utf8(toJSON(req))
  api_key = "LM7cDsjuUuPBgAmsC5l6xREfldo9sR1JukTbneBraIHGdT1p17zFz5TAvbR5z35wc05g1ZXNXhatyPqxa67lzw==" # Replace this with the API key for the web service
  authz_hdr = paste('Bearer', api_key, sep=' ')
  
  h$reset()
  curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/aba4b61d30814babbe06ae6b36e7a3ca/services/20d48c74a1674e849754da1dd9e74091/execute?api-version=2.0&details=true",
              httpheader=c('Content-Type' = "application/json", 'Authorization' = authz_hdr),
              postfields=body,
              writefunction = h$update,
              headerfunction = hdr$update,
              verbose = TRUE
  )
  
  headers = hdr$value()
  
  
  print("Interest Rate after KNN Clustering:")
  result = h$value()
  resultpred <- fromJSON(result)
  resultpred1 <- resultpred$Results$output1$value$Values[[1]][10]
  return(resultpred1)
  
  
}

http_function_Cluster_1  <- function(loan_amount_name,dti_name,ai_name,open_acc_name,revol_bal_name,revol_util_name,emp_name){
  
  
  # Accept SSL certificates issued by public Certificate Authorities
  options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
  
  h = basicTextGatherer()
  hdr = basicHeaderGatherer()
  
  
  req = list(
    
    Inputs = list(
      
      
      "input1" = list(
        "ColumnNames" = list("loan_amnt", "installment", "annual_inc", "emp_length_clean", "dti", "inq_last_6mths", "open_acc", "revol_bal", "revol_util"),
        "Values" = list( list( loan_amount_name, 500, ai_name, emp_name, dti_name, 3,open_acc_name , revol_bal_name, revol_util_name ))
      )                ),
    GlobalParameters = setNames(fromJSON('{}'), character(0))
  )
  
  body = enc2utf8(toJSON(req))
  api_key = "FS55vRbTAYQQri5EcMDxMc3bXMdgXd5M3VAdlJgpNaqhnIWSEzPBwlG7UUII976RBBlGVYE3aVzRSjZ0mn+acA==" # Replace this with the API key for the web service
  authz_hdr = paste('Bearer', api_key, sep=' ')
  
  h$reset()
  curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/aba4b61d30814babbe06ae6b36e7a3ca/services/3ccfb17acb3d4ddaa1f60cd0d3144dc6/execute?api-version=2.0&details=true",
              httpheader=c('Content-Type' = "application/json", 'Authorization' = authz_hdr),
              postfields=body,
              writefunction = h$update,
              headerfunction = hdr$update,
              verbose = TRUE
  )
  
  headers = hdr$value()
  httpStatus = headers["status"]
  if (httpStatus >= 400)
  {
    print(paste("The request failed with status code:", httpStatus, sep=" "))
    
    # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
    print(headers)
  }
  
  print("Interest Rate after KNN Clustering:")
  result = h$value()
  resultpred <- fromJSON(result)
  resultpred1 <- resultpred$Results$output1$value$Values[[1]][10]
  return(resultpred1)
  
}

##########################################################################################################################
###################################### WEB UI CODE ######################################################################
##########################################################################################################################

# Define UI for application that draws a histogram
ui <- pageWithSidebar(
  
  # Application title
  headerPanel("Outbrain Prediction"),
  
  sidebarPanel(
    textInput("ad_id", "Adid", 0, placeholder = NULL),
    textInput("Platform", "Platform", 1, placeholder = NULL),
    textInput("State", "State", 0, placeholder = NULL),
    textInput("Documentid", "Document_id", 0, placeholder = NULL),
    textInput("TrafficSource", "TrafficSource", 0, placeholder = NULL),
    textInput("Mean_cf", "ConfidenceLevel", 0.00, placeholder = NULL),
    
    
    
    submitButton("Submit")),
  
  # Show a plot of the generated distribution
  mainPanel(
    verbatimTextOutput("value_classification")
    
    
    #verbatimTextOutput("db_select"),
    #textOutput("Cluster_Output"),
    #verbatimTextOutput("Value_noclass"),
    #verbatimTextOutput("Value_cluster"),
    #textOutput("bat")
    
    
    
  )
  
)


##########################################################################################################################
###################################### WEB SERVER CODE #####################################################################
##########################################################################################################################

# Normalize Function
normalize <-  function(x) {
  log(x)
}

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  #output$LA <-renderPrint({input$LA})
  
  classify <- reactive({ http_function_classification(input$ad_id,input$Platform,input$State,input$Documentid,input$TrafficSource,input$Mean_cf)})
  
  output$value_classification <- renderText({paste("Probablity of AD getting clicked=:",classify())})
  
  
    
    
    
    
    #output$Cluster_Output <-renderPrint({http_function_KMEANS(input$LA,input$DTI,input$AI,input$OPEN_ACCOUNT,input$REVOL_BAL,input$REVOL_UTIL,input$Emp_Length)})
    
    #attm <- reactive({ http_function_KMEANS(input$LA,input$DTI,input$AI,input$OPEN_ACCOUNT,input$REVOL_BAL,input$REVOL_UTIL,input$Emp_Length)})
    
    #output$bat <- renderText(attm())
    
    #clusterknn <- reactive({
      #if (attm() == "No") {
       # test1 <- http_function_Cluster_0(input$LA,input$DTI,input$AI,input$OPEN_ACCOUNT,input$REVOL_BAL,input$REVOL_UTIL,input$Emp_Length)
    #  } else if (attm() == "Yes")
    #  {test1 <- http_function_Cluster_1(input$LA,input$DTI,input$AI,input$OPEN_ACCOUNT,input$REVOL_BAL,input$REVOL_UTIL,input$Emp_Length)
     # }
    #})
    
    #output$Value_cluster <- renderText({paste("Interest Rate after KNN Cluster:",clusterknn())})
    
  #} else {"Sorry No Loan"}
  #})
  
  #utput$bat <- renderText(yes_no())
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)