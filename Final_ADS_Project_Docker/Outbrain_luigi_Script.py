
# coding: utf-8

# In[1]:

import luigi
import Download_OutBrain_Data as scrape_data
import MetaData_For_Training as metadata_model_m
import Upload_To_S3 as s3_upload
import time

class Outbrain_data_download(luigi.Task):
    
    def requires(self):
        return []
    
    def output(self):
        return luigi.LocalTarget("clicks_test.csv")
    
    def run(self):
        scrape_data.download_data()
           
class Metadata_model(luigi.Task):
    
    def requires(self):
        time.sleep(40)
        return [Outbrain_data_download()]
    
    def output(self):
        return luigi.LocalTarget("Document_Metadata.csv","XGB_File_400trees_TrainDatafinal.csv","xgb_results.csv")    

    
    def run(self):
        time.sleep(40)
        print("running metadata_model script..")
        metadata_model_m.metadata_model()
              
class Upload_to_S3(luigi.Task):
    
    def requires(self):
        time.sleep(40)
        return [Metadata_model()]
    
    def run(self):
        time.sleep(40)
        print("running S3 script..")
        s3_upload.uploadToS3()

    
    
if __name__ == '__main__':
     luigi.run(['Upload_to_S3','--local-scheduler'])
    


# In[ ]:



