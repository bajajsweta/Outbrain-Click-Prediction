
# coding: utf-8

# In[9]:

import numpy as np
import pandas as pd 
import os
from sklearn.externals import joblib
from sklearn.ensemble import RandomForestClassifier
#from xgboost.sklearn import XGBClassifier
import pickle
import gc


# In[ ]:

def metadata_model():
    
    print('Inside the function')
    ### reading all the 7 csv files
    promoted_content = pd.read_csv('promoted_content.csv')
    document_category = pd.read_csv('documents_categories.csv')
    document_topic = pd.read_csv('documents_topics.csv')
    document_entity = pd.read_csv('documents_entities.csv')
    events_data = pd.read_csv('events.csv')
    clicks_train  = pd.read_csv('clicks_train.csv')
    clicks_test = pd.read_csv('clicks_test.csv')
    
    ### Split the DataFrame into smaller chunks
    size_of_chunk = 1000
    Df_List = list()
    numOfChunks = len(clicks_train) // size_of_chunk + 1
    for i in range(numOfChunks):
        Df_List.append(clicks_train[i*size_of_chunk:(i+1)*size_of_chunk])
        
        
    split_train_frame = Df_List
    ## reading the first chunk
    chunk_frame = split_train_frame[0]
    
    ## merge chunk frame with events data.
    merged_df_with_Event = pd.DataFrame(events_data)
    merged_df_with_Event.drop(['uuid','timestamp','document_id'],axis=1,inplace=True)
    merged_df_with_Event['Country']=merged_df_with_Event['geo_location'].str[0:2]
    merged_df_with_Event.drop(['geo_location'],axis=1,inplace=True)
    merged_df_with_Events = pd.merge(chunk_frame,merged_df_with_Event,how='left',on=(['display_id']))
    merged_df_with_Events['Country'] = pd.Categorical.from_array(merged_df_with_Events.Country).labels
    merged_df_with_Events = merged_df_with_Events.query("Country == Country")
    merged_df_with_Events['platform'] = pd.Categorical.from_array(merged_df_with_Events.platform).labels
    merged_df_with_Events['platform'] = pd.to_numeric(merged_df_with_Events['platform'], errors='ignore')
    
    #merged_df_with_Events.to_csv('merged_df_with_Events.csv',index=None)
    
    merged_df = pd.merge(merged_df_with_Events,promoted_content,how='left',on='ad_id')
    
    ## merge the above data with document_category data
    #merged_df_with_CL_Cat = merge_data_with_document_category(document_category,merged_df)
    
    average_category_confidenceLevel = pd.DataFrame(document_category.groupby(['document_id'])['confidence_level'].mean()).reset_index()
    merged_df_with_CL_Cat = pd.merge(merged_df,average_category_confidenceLevel,how='left',on='document_id')
    merged_df_with_CL_Cat = merged_df_with_CL_Cat[np.isfinite(merged_df_with_CL_Cat['confidence_level'])]
    merged_df_with_CL_Cat['confidence_level'] = merged_df_with_CL_Cat['confidence_level'].map('{:,.3f}'.format)
    merged_df_with_CL_Cat[['confidence_level']] = merged_df_with_CL_Cat[['confidence_level']].astype(float)
    gc.collect()
    ## grouping confidence level by document_id
    average_topic_confidenceLevel = pd.DataFrame(document_topic.groupby(['document_id'])['confidence_level'].mean()).reset_index()
    merged_df_with_CL_Top = pd.merge(merged_df_with_CL_Cat,average_topic_confidenceLevel,how='left',on='document_id')
    merged_df_with_CL_Top = merged_df_with_CL_Top[np.isfinite(merged_df_with_CL_Top['confidence_level_y'])]
    merged_df_with_CL_Top['confidence_level_y'] = merged_df_with_CL_Top['confidence_level_y'].map('{:,.3f}'.format)
    merged_df_with_CL_Top[['confidence_level_y']] = merged_df_with_CL_Top[['confidence_level_y']].astype(float)

    
    ## merge the above data with document_topic
    #merged_df_with_CL_Top = merge_data_with_document_topics(document_topic,merged_df_with_CL_Cat)
    average_entity_confidenceLevel = pd.DataFrame(document_entity.groupby(['document_id'])['confidence_level'].mean()).reset_index()
    merged_df_with_CL_Ent = pd.merge(merged_df_with_CL_Top,average_entity_confidenceLevel,how='left',on='document_id')
    merged_df_with_CL_Ent.to_csv("merged_df_with_CL_Ent.csv")
    merged_df_with_CL_Ent = pd.read_csv("merged_df_with_CL_Ent.csv")
    merged_df_with_CL_Ent = merged_df_with_CL_Ent[np.isfinite(merged_df_with_CL_Ent['confidence_level'])]
    merged_df_with_CL_Ent['confidence_level'] = merged_df_with_CL_Ent['confidence_level'].map('{:,.3f}'.format)
    merged_df_with_CL_Ent[['confidence_level']] = merged_df_with_CL_Ent[['confidence_level']].astype(float)
    merged_df_with_CL_Ent[['platform']] = merged_df_with_CL_Ent[['platform']].astype(int)
    merged_df_with_CL_Ent.drop(['Unnamed: 0'],axis=1,inplace=True)
    merged_df_with_CL_Ent.to_csv("Document_Metadata.csv", index=False)
    print("creating the model")

    ## Creating the trained model
    X = [x for x in merged_df_with_CL_Ent.columns if x not in ['display_id','clicked']]
    Y = ['clicked']
    #model = XGBClassifier(max_depth=3,n_estimators=400, learning_rate=0.02)
    model = RandomForestClassifier(random_state=1, n_estimators=3, min_samples_split=4, min_samples_leaf=2, n_jobs=3)
    train_model = model.fit(merged_df_with_CL_Ent[X],merged_df_with_CL_Ent[Y])

    ##creating test data..
    size_of_chunk_test = 1000
    Df_List_test = list()
    numOfChunks_test = len(clicks_test) // size_of_chunk_test + 1
    for i in range(numOfChunks_test):
        Df_List_test.append(clicks_test[i*size_of_chunk_test:(i+1)*size_of_chunk_test])
    
    split_test_frame = Df_List_test #splitDataFrameIntoSmaller(clicks_test)
    test = split_test_frame[0]
    
    print("Almost done")
    merged_df_with_Event['Country'] = pd.Categorical.from_array(merged_df_with_Event.Country).labels
    merged_df_with_Event = merged_df_with_Event.query("Country == Country")
    merged_df_with_Event['platform'] = pd.Categorical.from_array(merged_df_with_Event.platform).labels
    merged_df_with_Event['platform'] = pd.to_numeric(merged_df_with_Event['platform'], errors='ignore')
    
    chunk_test = pd.merge(test,merged_df_with_Event,how='left',on='display_id')
    print(chunk_test.head(1))
    chunk_test_promo = pd.merge(chunk_test,promoted_content,how='left',on='ad_id')
    
    chunk_test_with_CL_Cat = pd.merge(chunk_test_promo,average_category_confidenceLevel,how='left',on='document_id')
    chunk_test_with_CL_Cat = chunk_test_with_CL_Cat.fillna(0.0)
    
    chunk_test_with_CL_Top = pd.merge(chunk_test_with_CL_Cat,average_topic_confidenceLevel,how='left',on='document_id')
    chunk_test_with_CL_Top=chunk_test_with_CL_Top.fillna(0.0)
    
    chunk_test_with_CL_Ent = pd.merge(chunk_test_with_CL_Top,average_entity_confidenceLevel,how='left',on='document_id')
    chunk_test_with_CL_Ent=chunk_test_with_CL_Ent.fillna(0.0)
    
    chunk_test_with_CL_Ent.to_csv('TestData.csv',index=None)
    print("Saving Test Data Completed!")
    gc.collect()
    ## Save the model..
    
    save_model = pickle.dumps(train_model)
    load_model = pickle.loads(save_model)
    joblib.dump(train_model, 'xgboost.pkl')
    
    trained_model = joblib.load('xgboost.pkl')
    
    split_test_frame = Df_List_test #splitDataFrameIntoSmaller(clicks_test)
    test = split_test_frame[0]
    predY=[]
    
    X_test = [x for x in chunk_test_with_CL_Ent.columns if x not in ['display_id','clicked']]
    chunk_pred=list(trained_model.predict_proba(chunk_test_with_CL_Ent[X_test]).astype(float)[:,1])
    predY += chunk_pred
    results=pd.concat((clicks_test,pd.DataFrame(predY)) ,axis=1,ignore_index=True)
    #Combine the predicted values with the ids
    
    results.columns = ['display_id','ad_id','clicked']#Rename the columns
    
    results.to_csv("xgb_results.csv", index=False)
    results_1 = pd.read_csv('xgb_results.csv')
    results_1 = results_1.sort_values(by=['display_id','clicked'], ascending=[True, False])
    final_file = results_1.groupby('display_id').ad_id.apply(lambda x: " ".join(map(str,x))).reset_index()
    final_file.to_csv("XGB_File_400trees_TrainDatafinal.csv", index=False)
    
    ##Saving
    save_model = pickle.dumps(train_model)
    load_model = pickle.loads(save_model)
    joblib.dump(train_model, 'xgboost.pkl')
    
    trained_model = joblib.load('xgboost.pkl')
    
    
    print("Completed..")


# In[ ]:



