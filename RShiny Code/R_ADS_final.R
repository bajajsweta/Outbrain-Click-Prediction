
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
  resultclass1 <- round(as.numeric(resultclass1), 3)
  return(resultclass1)
}


################################################################################################################
########################################### KMEANS #############################################################
################################################################################################################
http_function_classification1  <- function(a){
  options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
  
  h = basicTextGatherer()
  hdr = basicHeaderGatherer()
  
  
  req = list(
    
    Inputs = list(
      
      
      "input1" = list(
        "ColumnNames" = list("display_id"),
        "Values" = list( list( a)  )
      )                ),
    GlobalParameters = setNames(fromJSON('{}'), character(0))
  )
  
  body = enc2utf8(toJSON(req))
  api_key = "bhg2dGpyI7HFuKjx3fHBdbNuD+lgpPAMnRaXtwgncIz1oWMtQpthvjkOENAUtiV7rcjoQQk9s9uPtMuqlhrhww==" # Replace this with the API key for the web service
  authz_hdr = paste('Bearer', api_key, sep=' ')
  
  h$reset()
  curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/9914aac9bbae449db36eb1771ecd1004/services/8aa3a29ce7af4fdf828b3a41d239cdba/execute?api-version=2.0&details=true",
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
  
  resulta <- fromJSON(result)
  resultb <- resulta$Results$output1$value$Values[[1]][2]
  return(resultb)
}
##########################################################################################################################
###################################### WEB UI CODE ######################################################################
##########################################################################################################################

# Define UI for application that draws a histogram
ui <- pageWithSidebar(
  
  
  
  # Application title
  headerPanel("Outbrain Prediction"),
  
  sidebarPanel(
   
    
    tabsetPanel(
      tabPanel("Probablity", textInput("name", "DisplayID", 22474926 , placeholder = NULL)),
               
      tabPanel("Indiviual Ad", textInput("ad_id", "Adid", 0, placeholder = NULL),
               textInput("Platform", "Platform", 1, placeholder = NULL),
               textInput("State", "State", 0, placeholder = NULL),
               textInput("Documentid", "Document_id", 0, placeholder = NULL),
               textInput("TrafficSource", "TrafficSource", 0, placeholder = NULL),
               textInput("Mean_cf", "ConfidenceLevel", 0.00, placeholder = NULL))
      #tabPanel("Table", tableOutput("table"))
    ),
    
    #textInput("name", "Name", 'Yogita', placeholder = NULL),
    submitButton("Submit")),
  
  
  
  # Show a plot of the generated distribution
  mainPanel(
    
    tabsetPanel(
      tabPanel("Probablity", verbatimTextOutput("value_classification1") ),
      
      tabPanel("Indiviual Ad", verbatimTextOutput("value_classification"))
    )
    
    
    
    
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
  classify1 <- reactive({ http_function_classification1(input$name)})
  
  output$value_classification <- renderText({paste("Probablity of Ad getting :: ",classify())})
  output$value_classification1 <- renderText({paste("Ad Id's by decreasing order of Probablity :: ",classify1())})
  
    
    
    
    
   
  
}

# Run the application 
shinyApp(ui = ui, server = server)