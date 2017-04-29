
# coding: utf-8

# In[7]:

import numpy as np
import pandas as pd
import pickle
from sklearn.externals import joblib


# In[57]:

load_model = joblib.load('xgboost.pkl')


# In[58]:

test_data = pd.read_csv('TestData.csv')


# In[59]:

test_ = test_data[:15]


# In[60]:

test_.head(2)


# In[62]:

X = [x for x in test_.columns if x not in ['display_id','clicked']]


# In[63]:

pred = load_model.predict_proba(test_[X])


# In[65]:

chunk_pred=list(load_model.predict_proba(test_[X]).astype(float)[:,1])


# In[67]:

predY=[]
predY += chunk_pred


# In[69]:

test_1 = test_[['display_id','ad_id']] 


# In[70]:

results=pd.concat((test_1,pd.DataFrame(predY)) ,axis=1,ignore_index=True)#Combine the predicted values with the ids


# In[72]:

results.columns = ['display_id','ad_id','clicked']#Rename the columns


# In[74]:

results.to_csv("xgb_results.csv", index=False)


# In[75]:

results_1 = pd.read_csv('xgb_results.csv')


# In[77]:

results_1 = results_1.sort_values(by=['display_id','clicked'], ascending=[True, False])


# In[79]:

final_file = results_1.groupby('display_id').ad_id.apply(lambda x: " ".join(map(str,x))).reset_index()


# In[84]:


final_file.to_csv("PredictedOutput.csv", index=False)


# In[86]:

print(final_file.head(1))


# In[ ]:



