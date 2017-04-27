
# coding: utf-8

# In[1]:

import pandas as pd
import os
import glob
import zipfile as z
import requests
import io
import mechanicalsoup
import time


# In[78]:

def download_data():
    
    folderName = '/DownloadedData'
    print("Creating the Data Folder after checking if it already is present and if it isnt then create one!")
    curr_dir = os.getcwd()
    Data_dir = curr_dir+'/'+folderName
    if not os.path.exists(Data_dir):
        os.makedirs(Data_dir)
    
    s = requests.session()
    payload = {'username': 'yogitaj508@gmail.com', 'password': 'yogitaj508'}
    url = 'https://www.kaggle.com/account/login?ReturnUrl=%2faccount%2fset-username%3freturnUrl%3d%2fc%2foutbrain-click-prediction&returnUrl=/c/outbrain-click-prediction'
    a = s.post(url, data=payload)
    
    clicks_test= 'https://www.kaggle.com/c/outbrain-click-prediction/download/clicks_test.csv.zip'
    file1 = s.get(clicks_test)
    m1 = z.ZipFile(io.BytesIO(file1.content))
    m1.extractall(Data_dir)
    
    clicks_train= 'https://www.kaggle.com/c/outbrain-click-prediction/download/clicks_train.csv.zip'
    file2 = s.get(clicks_train)
    m2 = z.ZipFile(io.BytesIO(file2.content))
    m2.extractall(Data_dir)

    documents_categories= 'https://www.kaggle.com/c/outbrain-click-prediction/download/documents_categories.csv.zip'
    file3 = s.get(documents_categories)
    m3 = z.ZipFile(io.BytesIO(file3.content))
    m3.extractall(Data_dir)

    documents_entities= 'https://www.kaggle.com/c/outbrain-click-prediction/download/documents_entities.csv.zip'
    file4 = s.get(documents_entities)
    m4 = z.ZipFile(io.BytesIO(file4.content))
    m4.extractall(Data_dir)

    documents_meta= 'https://www.kaggle.com/c/outbrain-click-prediction/download/documents_meta.csv.zip'
    file5 = s.get(documents_meta)
    m5 = z.ZipFile(io.BytesIO(file5.content))
    m5.extractall(Data_dir)

    documents_topics= 'https://www.kaggle.com/c/outbrain-click-prediction/download/documents_topics.csv.zip'
    file6 = s.get(documents_topics)
    m6 = z.ZipFile(io.BytesIO(file6.content))
    m6.extractall(Data_dir)

    events= 'https://www.kaggle.com/c/outbrain-click-prediction/download/events.csv.zip'
    file7 = s.get(events)
    m7 = z.ZipFile(io.BytesIO(file7.content))
    m7.extractall(Data_dir)

    page_views_sample= 'https://www.kaggle.com/c/outbrain-click-prediction/download/page_views_sample.csv.zip'
    file8 = s.get(page_views_sample)
    m8 = z.ZipFile(io.BytesIO(file8.content))
    m8.extractall(Data_dir)

    promoted_content= 'https://www.kaggle.com/c/outbrain-click-prediction/download/promoted_content.csv.zip'
    file9 = s.get(promoted_content)
    m9 = z.ZipFile(io.BytesIO(file9.content))
    m9.extractall(Data_dir)

    print("Download Completed.")

    

    


# In[79]:

download_data()


# In[ ]:



