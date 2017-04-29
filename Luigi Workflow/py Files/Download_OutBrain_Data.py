
# coding: utf-8

# In[3]:

import pandas as pd
import os
import zipfile as z
import requests
import io


# In[2]:

def download_data():
    
    print("Dowloading of data started!")
    ursname = input("Enter username:")
    pswd = input("Enter password:")
    
    s = requests.session()
    payload = {'username': ursname, 'password': pswd}
    url = 'https://www.kaggle.com/account/login?ReturnUrl=%2faccount%2fset-username%3freturnUrl%3d%2fc%2foutbrain-click-prediction&returnUrl=/c/outbrain-click-prediction'
    a = s.post(url, data=payload)
    
    clicks_test= 'https://www.kaggle.com/c/outbrain-click-prediction/download/clicks_test.csv.zip'
    file1 = s.get(clicks_test)
    m1 = z.ZipFile(io.BytesIO(file1.content))
    m1.extractall()
    
    clicks_train= 'https://www.kaggle.com/c/outbrain-click-prediction/download/clicks_train.csv.zip'
    file2 = s.get(clicks_train)
    m2 = z.ZipFile(io.BytesIO(file2.content))
    m2.extractall()

    documents_categories= 'https://www.kaggle.com/c/outbrain-click-prediction/download/documents_categories.csv.zip'
    file3 = s.get(documents_categories)
    m3 = z.ZipFile(io.BytesIO(file3.content))
    m3.extractall()

    documents_entities= 'https://www.kaggle.com/c/outbrain-click-prediction/download/documents_entities.csv.zip'
    file4 = s.get(documents_entities)
    m4 = z.ZipFile(io.BytesIO(file4.content))
    m4.extractall()

    documents_meta= 'https://www.kaggle.com/c/outbrain-click-prediction/download/documents_meta.csv.zip'
    file5 = s.get(documents_meta)
    m5 = z.ZipFile(io.BytesIO(file5.content))
    m5.extractall()

    documents_topics= 'https://www.kaggle.com/c/outbrain-click-prediction/download/documents_topics.csv.zip'
    file6 = s.get(documents_topics)
    m6 = z.ZipFile(io.BytesIO(file6.content))
    m6.extractall()

    events= 'https://www.kaggle.com/c/outbrain-click-prediction/download/events.csv.zip'
    file7 = s.get(events)
    m7 = z.ZipFile(io.BytesIO(file7.content))
    m7.extractall()

    page_views_sample= 'https://www.kaggle.com/c/outbrain-click-prediction/download/page_views_sample.csv.zip'
    file8 = s.get(page_views_sample)
    m8 = z.ZipFile(io.BytesIO(file8.content))
    m8.extractall()

    promoted_content= 'https://www.kaggle.com/c/outbrain-click-prediction/download/promoted_content.csv.zip'
    file9 = s.get(promoted_content)
    m9 = z.ZipFile(io.BytesIO(file9.content))
    m9.extractall()

    print("Download Completed.")

    

    


# In[ ]:



