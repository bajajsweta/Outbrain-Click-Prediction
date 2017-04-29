# Outbrain-Click-Prediction
<hr>

![screen shot 2017-04-28 at 11 06 49 pm](https://cloud.githubusercontent.com/assets/21116708/25552417/6fe17abc-2c67-11e7-8e0a-5714286a572f.png)

# Deliverables
<hr>

Project Proposal Video : https://www.youtube.com/watch?v=IeKPIaOxPJI

RShiny Deployed Link: https://outbrainproject.shinyapps.io/WebOutBrain/

Tableau Online link: https://us-east-1.online.tableau.com/#/site/ads_outbrain_finalproject/workbooks
(Note:  since data file was big tableau server was used. Please use your credentials to login in view the dashboard)

Final Report document: ADS_Final_Project_Report_Team8.docx

DockerHub Link : : https://hub.docker.com/r/sweta/outbrain_prediction/

Project Demo Link: https://www.youtube.com/watch?v=19ihFCw8RIM

Final Presentation Link :ADS_Final_Project_Team8.pptx

Tools used: R, R-shiny for web devolpment, Python, Plotly and Tableau for analysis, Docker, IBM Data Science, Microsoft Azure, AWS

# Note
In Exploratory analysis we have used plotly in offline mode, hence the graph will not be visible unless the code is run.
The Report has all the graph images along with the explanation.


## PROBLEM STATEMENT:
<hr>

Millions of user use social network for surfing, visiting countless websites and clicking on countless ads/recommendations  on these website.
Knowing what the users are interested in and what the users are using in real world would be of great significance for future recommendations used by marketing team to attract potential users
as well as ad placements and real time bidding
Predicting the likelihood of users clicking on a particular content
Ranking the recommendations in each group by decreasing predicted likelihood of being clicked

We have made Kaggle submission of random forest model. The model is evaluated as shown in the image below

![screen shot 2017-04-28 at 11 31 33 pm](https://cloud.githubusercontent.com/assets/21116708/25552615/cc285f02-2c6c-11e7-8e04-fde3d97d6ec5.png)

and below is the model evaulation

![whatsapp image 2017-04-28 at 11 48 48 pm](https://cloud.githubusercontent.com/assets/21116708/25552645/5adedaf0-2c6d-11e7-93e1-f4a5bce0bed6.jpeg)


* Below is a screenshot of rest API that will predict advertisement ids for an individual display id.

![click probability](https://cloud.githubusercontent.com/assets/21116708/25552442/c4d45670-2c67-11e7-9f97-e2ccf68b36d7.JPG)

* Below is the screenshot of rest API that will predict individual ad click probablity

![whatsapp image 2017-04-28 at 11 51 04 pm](https://cloud.githubusercontent.com/assets/21116708/25552661/9fc97832-2c6d-11e7-8457-79779458a669.jpeg)


# Exploratory Analysis

### Analysis 1
<hr>

![screen shot 2017-04-28 at 11 16 21 pm](https://cloud.githubusercontent.com/assets/21116708/25552472/c0150d2c-2c68-11e7-9c9e-53e411ab7090.png)

#### Observations
* Maximum percentage of clicks were made through mobile phones, followed by desktop and then tablets. Mainly because: 

* App Availability: the app is available that is available on desktop is now present on model too.

* Convenience:  Games or social networking apps frequently serve as a way to pass the time while on the subway commuting home or in a cab or surfing net. This directly reflects the increase in uses of mobile devices    

#### Analysis 2
<hr>

![clicks_by_hour_events_table](https://cloud.githubusercontent.com/assets/21116708/25552475/cb66b1c6-2c68-11e7-8aef-fd0a299863d3.png)

#### Observations
* We observed that the click frequency is very high between 10-15 hrs. Around 10-11 a.m. time people are usually on their commute to work, school etc. and pass their time surfing net. Around 1-3 p.m. is usually lunch time where people get time to surf internet and that’s the frequency is high.

* The frequency in the bucket 15-20 is again when people are traveling back home and around dinner time when they have time to surf internet.

### Analysis 3
<hr>

![screen shot 2017-04-26 at 10 22 26 am](https://cloud.githubusercontent.com/assets/21116708/25552522/f1240bce-2c69-11e7-8ee2-f8eeb3a00f78.png)

#### Observations
* The number of clicks increase from 9.am. and reaches highest at around 10 a.m. and remains high till 12p.m. and then gradually decreases till it hits 3.p.m. It again rises from 3p.m.


### Analysis 4 
<hr>

![screen shot 2017-04-28 at 7 35 57 pm](https://cloud.githubusercontent.com/assets/21116708/25552510/9b2d6e18-2c69-11e7-9069-53b87e8784d4.png)

#### Observations
From the dashboard we can conclude that USA that the maximum number of view rate. The frequency of clicks gradually increases from 6 am and was high around 10 a.m. to 12 p.m.
The click was highest on Day 0 which is June 14th. It is a US national holiday


### Analysis 5
<hr>

![screen shot 2017-04-28 at 7 36 39 pm](https://cloud.githubusercontent.com/assets/21116708/25552511/a156f3e0-2c69-11e7-8027-8fe7b936a946.png)

#### Observations
* California state has the maximum number of views.
* The maximum number of views were from mobile devices at around 11 a.m. 


