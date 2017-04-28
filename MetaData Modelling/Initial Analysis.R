## Initial Analysis

Page_Events_clicks_topic_data$display_id <- as.factor(Page_Events_clicks_topic_data$display_id)
Page_Events_clicks_topic_data$uuid <- as.factor(Page_Events_clicks_topic_data$uuid)
Page_Events_clicks_topic_data$document_id <- as.factor(Page_Events_clicks_topic_data$document_id)
Page_Events_clicks_topic_data$platform <- as.factor(Page_Events_clicks_topic_data$platform)
Page_Events_clicks_topic_data$state <- as.factor(Page_Events_clicks_topic_data$state)
Page_Events_clicks_topic_data$traffic_source <- as.factor(Page_Events_clicks_topic_data$traffic_source)
Page_Events_clicks_topic_data$clicked <- as.factor(Page_Events_clicks_topic_data$clicked)

as.data.frame(table(Page_Events_clicks_topic_data$clicked))


length(unique(Page_Events_clicks_topic_data_1$display_id))
length(unique(Page_Events_clicks_topic_data_1$ad_id))


head(promoted_content_data)
a <- as.data.frame(table(promoted_content_data$document_id))


document_category_data <- fread("documents_categories.csv", sep=',')
document_entity_data <- fread("documents_entities.csv",sep=',')
document_meta_data <- fread("documents_meta.csv",sep=',')
document_topics_data <- fread("documents_topics.csv",sep=',')

length(unique(document_category_data$document_id))
length(unique(document_entity_data$document_id))
length(unique(document_topics_data$document_id))
length(unique(promoted_content_data$campaign_id))

