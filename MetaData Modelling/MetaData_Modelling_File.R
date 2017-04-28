library(data.table)
library(dplyr)

###########################################################################################################
########################   Load the Data -- 8 tables and 32 Variables #####################################
###########################################################################################################
click_test_data <- fread("clicks_test.csv",sep=',')

click_train_data <- fread("clicks_train.csv",sep=',')
events_data <- fread("events.csv", sep=',')
promoted_content_data <- fread("promoted_content.csv", sep=',')
page_view_sample_data <- fread("page_views_sample.csv",sep=',')
document_category_data <- fread("documents_categories.csv", sep=',')
document_entity_data <- fread("documents_entities.csv",sep=',')
document_meta_data <- fread("documents_meta.csv",sep=',')
document_topics_data <- fread("documents_topics.csv",sep=',')


############################################################################################################
#######################  Data Modelling        #############################################################
############################################################################################################

###################### EVENTS DATASET #####################################################################

events_data$country <- substr(events_data$geo_location, 1, 2)
events_data$state <- substr(events_data$geo_location,4,5)
head(events_data)

Events_US_Data <- events_data[events_data$country == 'US',]
head(Events_US_Data)

####### Remove the Columns from the Events dataset 

Events_US_Data <- select(Events_US_Data , -c(geo_location))
Events_US_Data <- select(Events_US_Data , -c(timestamp))
Events_US_Data$factor <- as.numeric(as.factor(Events_US_Data$state))
Events_US_Data <- filter(Events_US_Data, factor > 1)
Events_US_Data <- select(Events_US_Data , -c(factor))

####### States
Grouped_By_States <- as.data.frame(table(Events_US_Data$state))
top_10States <- c("CA","TX","FL","NY","PA","IL","OH","MI","NC","NJ")
Events_US_10States <- filter(Events_US_Data, state %in% top_10States )
Events_US_10States <- select(Events_US_10States , -c(country))
head(Events_US_10States)

###################### PAGE VIEW SAMPLE DATASET #######################

page_view_sample_data <- select(page_view_sample_data , -c(timestamp))

page_view_sample_data$country <- substr(page_view_sample_data$geo_location, 1, 2)
page_view_sample_data$state <- substr(page_view_sample_data$geo_location,4,5)
head(page_view_sample_data)

page_view_sample_US_Data <- page_view_sample_data[page_view_sample_data$country == 'US',]
head(page_view_sample_US_Data)
page_view_sample_US_10States <- filter(page_view_sample_US_Data, state %in% top_10States )
page_view_sample_US_10States <- select(page_view_sample_US_10States , -c(country))
page_view_sample_US_10States <- select(page_view_sample_US_10States , -c(geo_location))
head(page_view_sample_US_10States)


###########################################################################################################
################### Merge All the Files ###################################################################
###########################################################################################################

### --- Inner Join between Events and Click Train Data

Events_clicks_data <- inner_join(Events_US_10States,click_train_data)
platform_test <- as.data.frame(table(Events_clicks_data$platform))
platform_values <- c("1","2","3")
Events_clicks_data <- Events_clicks_data[Events_clicks_data$platform %in% platform_values,]
Events_clicks_data$platform <- as.integer(Events_clicks_data$platform)
head(Events_clicks_data)

### --- Left Join between Page Views and Events_Click_Data Dataframes

length(unique(page_view_sample_US_10States$uuid))
length(unique(Events_clicks_data$uuid))

Page_Events_clicks_data <- left_join(Events_clicks_data,page_view_sample_US_10States)
unique(Page_Events_clicks_data$traffic_source)

### --- Replace NA with 0 

traffic_Source_test <- as.data.frame(table(Page_Events_clicks_data$traffic_source))
Page_Events_clicks_data$traffic_source <- replace(Page_Events_clicks_data$traffic_source,is.na(Page_Events_clicks_data$traffic_source),0)

head(Page_Events_clicks_data)
length(unique(Page_Events_clicks_data$document_id))

### --- Logic for average confidence level ############################################################################

document_topics_new <- document_topics_data %>% select(document_id, confidence_level)

document_topic_aggregate <- document_topics_new %>%
                            group_by(document_id) %>%
                            summarise(mean_cf = mean(confidence_level) )
                             
### --- Inner Join with the Document Topics Data

Page_Events_clicks_topic_data_1 <- inner_join(Page_Events_clicks_data,document_topic_aggregate)

write.csv(Page_Events_clicks_topic_data_1, file = "Merged_data_File.csv")


