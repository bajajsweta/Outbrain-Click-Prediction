
# coding: utf-8

# In[5]:

import boto
from boto.s3.connection import S3Connection
from boto.s3.connection import Key

def uploadToS3():
    
    key = input("Enter the AWSKey:")
    secretkey = input("Enter the Secret Key:")
    awsKey = key  # 
    awsSecret = secretkey #
    
    bucname = input("Enter the bucket name:")
    
    conn = S3Connection(awsKey,awsSecret)
        #print(conn)
    print("inside Upload function..")
        #Connecting to a bucket
    bucket_name = bucname #"luigibuckets"
    bucket = conn.get_bucket(bucket_name)
    print(bucket)
        #Setting the keys
    k = Key(bucket)
    print (k)
    k.key = "XGB_File_400trees_TrainDatafinal.csv"
    k.set_contents_from_filename("XGB_File_400trees_TrainDatafinal.csv")
    
    k2 = Key(bucket)
    k2.key = "documents_meta.csv"
    k2.set_contents_from_filename("documents_meta.csv")
    
    k3 = Key(bucket)
    k3.key = "xgb_results.csv"
    k3.set_contents_from_filename("xgb_results.csv")
    
    k4 = Key(bucket)
    k4.key = "xgboost.pkl"
    k4.set_contents_from_filename("xgboost.pkl")
    
    print('Upload Completed..')


# In[ ]:



