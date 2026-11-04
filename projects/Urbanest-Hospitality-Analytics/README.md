# **UrbanNest Hospitality — Revenue \& Booking Analytics**



An end-to-end data analytics and predictive modelling project analysing 85,501 cleaned hotel bookings from 2015–2017 across City and Resort Hotels to understand booking behaviour, cancellation exposure, seasonal demand, and the factors associated with booking value.



The project combines Python, SQL, statistical analysis, and multiple linear regression to transform hotel booking data into business insights and actionable recommendations.





### **Project Snapshot**



\- Cleaned bookings analysed: 85,501

\- Original records: 119,390

\- Analysis period: 2015–2017

\- Calculated booking value: €34.31M

\- Overall cancellation rate: 27.84%

\- Cancellation-associated booking value: ≈ €11.43M

\- Final regression R²: 0.844

\- Cross-validation R²: 0.840 ± 0.008

\- 2017 time-based test R²: 0.82



**Important**: Booking value in this project is calculated as "ADR × total nights". It represents the value associated with a booking record and should not be interpreted as confirmed cash revenue. For cancelled bookings, the calculated value represents the original booked value, not necessarily an actual financial loss.»





### **Project Overview**



UrbanNest Hospitality operates across City Hotels and Resort Hotels, with booking activity influenced by seasonality, customer type, distribution channel, room type, length of stay, and other booking characteristics.



The objective of this project was to analyse historical booking data to answer two connected business needs:



\- Understand what drives booking value and hotel performance.

\- Identify where cancellations and seasonal patterns create revenue risk or opportunities for improvement.



The analysis moves from data preparation and exploratory analysis into SQL analysis and predictive modelling, before translating the findings into business recommendations.





### **Business Questions**



The project focused on questions such as:



1\. How does booking demand change across months and hotel types?

2\. Which channels contribute the most bookings and booking value?

3\. Where is cancellation risk concentrated?

4\. How do room type, length of stay, customer type, and other booking characteristics relate to booking value?

5\. Which periods represent high- and low-demand opportunities?

6\. Can booking characteristics be used to estimate booking value?

7\. What actions could help reduce cancellation exposure and improve booking performance?





### **Dataset**



The original dataset contained:



\- 119,390 hotel booking records

\- 32 variables

\- City Hotel and Resort Hotel bookings

\- Booking information covering 2015–2017



After data preparation and quality-control steps, 85,501 bookings remained for analysis.



The analysis included variables covering areas such as:



\- Hotel type

\- Arrival date

\- Length of stay

\- Number of guests

\- Lead time

\- Room type

\- Meal plan

\- Market segment

\- Distribution channel

\- Customer type

\- Deposit type

\- Booking changes

\- Special requests

\- ADR

\- Cancellation status





### **Data Preparation**



The raw dataset required several cleaning and transformation steps before analysis.



Key cleaning steps



\- Removed 32,020 duplicate records.

\- Removed fields with substantial missingness, including "agent" and "company".

\- Replaced missing "children" values with "0".

\- Replaced missing country values with "Unknown".

\- Created total nights from weekend and weekday stays.

\- Created booking value using:



Booking Value = ADR × Total Nights



\- Removed 651 zero-night bookings.

\- Removed 1,128 records with zero or negative ADR.

\- Removed 90 extreme ADR observations with ADR ≥ €335.

\- Addressed remaining invalid or undefined categorical observations before modelling.

\- Confirmed that the final analytical dataset contained no remaining missing values or duplicate records.



These steps reduced the dataset from 119,390 original records to 85,501 cleaned bookings.





### **Exploratory \& Business Analysis**



The analysis examined booking behaviour across ***hotel type, seasonality, channels, room categories, customer types, and booking characteristics.***



#### **Seasonality**



Demand was not evenly distributed throughout the year.



July and August recorded the largest raw booking volumes, with:



\- August: 11,044 bookings

\- July: 9,881 bookings



However, these months appeared across three years while several other months appeared across two years. After adjusting for yearly coverage, April–June showed particularly strong booking activity, while November–January represented lower-demand periods.



August also generated the highest calculated booking value, at approximately €4.55M.



#### **Hotel Type**



The dataset contained:



\- 52,324 City Hotel bookings

\- 33,177 Resort Hotel bookings



City Hotels generated greater total completed booking value because of their larger booking volume.



However, Resort Hotel bookings had a higher average booking value:



\- Resort: ≈ €469

\- City: ≈ €358



This difference reflects the importance of considering both volume and value per booking when evaluating hotel performance.



#### **Cancellation Exposure**



Overall, approximately 27.84% of bookings were cancelled.



Cancellation exposure was particularly concentrated in the Online Travel Agent (Online TA) channel.



Online TA recorded:



\- 18,202 cancelled bookings

\- Approximately 35.5% cancellation rate

\- Approximately €9.25M in cancellation-associated booking value



This represented approximately 81% of all cancellation-associated booking value in the analysis.



#### **Room Type**



Room categories showed substantial differences in booking value.



While Room A accounted for the largest number of completed bookings, premium room categories such as C, G and H recorded substantially higher average booking values.



This suggested an opportunity to investigate targeted room-upgrade and upselling strategies rather than focusing only on increasing booking volume.



#### **Customer Type**



##### Average Booking Value by Customer Type



\- Contract: ≈ €527

\- Transient: ≈ €413

\- Group: ≈ €266



#### **Booking Characteristics**



Length of stay showed the strongest relationship with booking value among the examined numerical variables.



Correlation with booking value included:



\- Length of stay: r = 0.75

\- ADR: r = 0.54



Other variables, including lead time, number of adults, and special requests, showed weaker relationships.





### **SQL Analysis**



SQL was used to investigate the booking dataset from a business-analysis perspective.



The SQL analysis examined areas including:



\- Booking and cancellation performance

\- Hotel-level performance

\- Seasonal ADR patterns

\- Market segment performance

\- Room-type booking value

\- Channel performance

\- Customer behaviour



One notable result was the seasonal movement in ADR.



Average ADR increased from approximately:



\- €71.91 in January

\- €137.28 in July

\- €151.91 in August



This provided additional evidence of significant seasonal variation in pricing and booking value.





### **Predictive Modelling**



A multiple linear regression model was developed to estimate booking value using booking-level characteristics.



The modelling process progressed through increasingly comprehensive feature sets.



#### **Models Evaluated**



###### **Model 1 — 5 Numerical Features**

\- R²: 0.635

\- MAE: €137.21

\- RMSE: €220.31



###### **Model 2 — 45 Inputs**

\- R²: 0.762

\- MAE: €115.13

\- RMSE: €177.89



###### **Final Model — 64 Inputs**

\- R²: 0.844

\- MAE: €90.82

\- RMSE: €144.27



The final model incorporated booking characteristics including:



\- Hotel

\- Arrival year and month

\- Weekend and weekday nights

\- Lead time

\- Adults and children

\- Meal plan

\- Market segment

\- Distribution channel

\- Reserved room type

\- Booking changes

\- Special requests

\- Deposit type

\- Customer type



Interaction terms were also included for:



\- Resort × month

\- Total nights × room type



The data was divided into 80% training and 20% testing sets.



The final model achieved an R² of 0.844, with an MAE of approximately €90.82.





### **Model Validation**



The model was evaluated beyond a single train/test split.



###### **Cross-validation**



The model achieved:



R² = 0.840 ± 0.008



This indicated relatively consistent performance across the cross-validation folds.



###### **Time-based validation**



A separate time-based evaluation trained the model using 2015–2016 data and tested it on 2017 data.



The resulting:



2017 R² = 0.82



The model predicted an average 2017 booking value of approximately €456, compared with an actual average of approximately €454.



This provided additional evidence that the model retained useful predictive performance when evaluated on a later period.





### **Model Limitations**



The regression model is useful for decision support, but it should not be treated as a finished pricing or forecasting engine.



The analysis identified several limitations:



\- The relationship between some variables and booking value is not perfectly linear.

\- Higher-value and longer stays showed evidence of greater variance in prediction errors.

\- Approximately 5.1% of test predictions were below zero, which is not meaningful for booking value and would require post-processing in a practical implementation.

\- The dataset does not include factors such as competitor pricing, events, promotions, room capacity, commission costs, or operating costs.

\- Historical price trends suggest the model would require periodic retraining.

\- Booking value is not equivalent to realised cash revenue.



These limitations are important when interpreting the model's business usefulness.





### **Key Findings**



###### **01 — Cancellation exposure is concentrated in Online TA**



Online TA accounted for the largest share of cancellation-associated booking value, making cancellation management within this channel a major opportunity.



###### **02 — Seasonality strongly influences demand and value**



July and August showed particularly strong raw booking activity, while November–January represented weaker demand periods.



###### **03 — Higher-value bookings are associated with longer stays**



Length of stay had the strongest observed correlation with booking value among the numerical variables examined.



###### **04 — Premium room categories generate substantially higher booking values**



Room categories such as C, G and H showed considerably higher average booking values than the high-volume Room A category.



###### **05 — Hotel type affects both volume and value**



City Hotels generated greater total completed booking value because of higher volume, while Resort Hotels had higher average booking values.



###### **06 — Booking characteristics can meaningfully estimate booking value**



The final regression model achieved an R² of 0.844, with additional validation producing 0.82 R² on the 2017 time-based test.





### **Business Recommendations**



Based on the analysis, the project recommends:



###### **1. Strengthen Online TA cancellation management**



Monitor cancellation behaviour by channel, booking period, and customer characteristics, and test strategies aimed at reducing unnecessary cancellation exposure.



###### **2. Increase direct booking opportunities**



The analysis indicates substantially stronger value retention for direct bookings compared with Online TA, creating a potential opportunity to encourage customers toward direct channels.



###### **3. Plan proactively for peak season**



July and August require preparation for high demand, while pricing and capacity decisions should also consider the strong adjusted demand observed during April–June.



###### **4. Target low-demand periods**



November–January present an opportunity for targeted offers designed to stimulate demand and encourage longer stays.



###### **5. Explore premium-room upselling**



The large difference in booking value across room categories supports testing targeted upgrade strategies.



###### **6. Monitor performance continuously**



A practical implementation should track bookings, cancellations, booking value, channel performance, and seasonal changes over time.





### **Estimated Business Impact**



The analysis also translated selected findings into potential annualised business scenarios.



###### **Online TA Cancellation Reduction**



\- 2 percentage-point reduction: ≈ €0.24M annually

\- 5 percentage-point reduction: ≈ €0.60M annually

\- 10 percentage-point reduction: ≈ €1.20M annually



The analysis estimates that each 1 percentage-point reduction in Online TA cancellations corresponds to approximately €0.12M in annualised booking value.





###### **Room Upgrade Opportunities For Room A to Room D**



\- 2% upgrade rate: ≈ €0.07M annually

\- 5% upgrade rate: ≈ €0.17M annually

\- 10% upgrade rate: ≈ €0.34M annually



These figures are scenario estimates rather than guaranteed financial returns. In particular, the room-upgrade estimates represent an upper-bound opportunity because Room D bookings tend to involve longer stays.





### **Example Model Application**



The model illustrates how booking characteristics can produce substantially different estimated booking values.



For example, a comparable 4-night stay was estimated at approximately:



\- €370 for a City Hotel booking in January with Room A

\- €1,028 for a Resort Hotel booking in August with Room G



This demonstrates how hotel type, season, room category, and length of stay can interact to influence estimated booking value.





### **Limitations \& Responsible Interpretation**



This project should be interpreted as a historical analytics and decision-support exercise, not as a complete hotel revenue-management system.



#### **Important limitations include:**



\- Calculated booking value is not confirmed cash revenue.

\- Cancelled booking value is not necessarily equivalent to realised financial loss.

\- The dataset does not contain competitor pricing, events, promotions, room capacity, commissions, or operating costs.

\- The model should be periodically retrained as booking behaviour changes.

\- Predictions should be constrained to meaningful values, including a minimum of €0.

\- Model outputs should support—not replace—business and revenue-management judgement.





### **Project Structure**



UrbanNest-Hospitality/

│

├── HOSPITALITY\_CAPSTONE\_MASTER\_v4.ipynb

├── group3\_hotel\_analysis.sql

├── Group3\_UrbanNest\_Report\_v4

├── README.md

└── requirements.txt





### **Getting Started**



Clone the repository



git clone <repository-url>

cd UrbanNest-Hospitality



Install dependencies



pip install -r requirements.txt



Run the analysis



Open:



HOSPITALITY\_CAPSTONE\_MASTER\_v4.ipynb



and execute the notebook sequentially.



The SQL analysis is available in:



group3\_hotel\_analysis.sql





### **Future Extensions**



The analysis provides a foundation for further development.



#### **Potential next steps include:**



\- Developing a dedicated cancellation-risk model.

\- Incorporating room capacity and availability.

\- Incorporating commission and operating-cost data.

\- Moving from booking-value analysis toward profitability analysis.

\- Improving the predictive approach for cases where booking-value variance is not constant.

\- Developing a more operational monitoring workflow for channel, cancellation, and seasonal performance.





### **Contributors**



* **Anayo Nwoba**
* **Amaka Igbonezim**
* **Abdulazeez Sani**
* **Salihu Kabiru**
* **Durojaye Tosin Eniola**
* **Jacinta Syekau**
* **Stephen Bonu**
* **Shalom Okanlawon**
* **Bunmi Dunmiye**
* **Aanu Adesemoye**
* **Elenwo Chikem**

