pip install sqlalchemy 
pip install pymysql
from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://root:NAMITgoku@07@localhost:3306/pharma')
query = "select * from inventory"
inventory = pd.read_sql(query, engine)

pip install pandas openpyxl
inventory.to_excel('data.xlsx', index=False)

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt


inventory= pd.read_csv(r'C:/Namit/Project 1-Pharmaceutical Inventory Management/Data Set/pharma dataset new.csv')
inventory.info()
inventory.describe()
inventory.isnull().sum()

#EXPLORATORY DATA ANALYSIS
#Calculating statistical measures like mean, median, mode, range, variance, kurtosis, skewness, and standard deviation is essential for understanding the distribution, central tendency, and spread of your data. 
#These measures provide insights into the data's structure, helping you make informed decisions during data analysis, preprocessing, and modeling.
#FIRST BUSINESS MOMENTS
#MEAN
#mean provides a measure of the central tendency, indicating the average value of a dataset.
mean1= inventory['Qty_in_Unit_of_ Entry'].mean()
mean2= inventory['Qty_in_OPUn'].mean()
mean3= inventory['Qty_in_order_unit'].mean()
mean4= inventory['Amount_in_LC'].mean()
mean5= inventory['Item'].mean()
mean6= inventory['Quantity'].mean()

#MEDIAN
#It is a robust measure of central tendency, especially when dealing with skewed distributions or outliers.
median1= inventory['Qty_in_Unit_of_ Entry'].median()
median2= inventory['Qty_in_OPUn'].median()
median3= inventory['Qty_in_order_unit'].median()
median4= inventory['Amount_in_LC'].median()
median5= inventory['Item'].median()
median6= inventory['Quantity'].median()

#MODE
#Important in categorical data to understand the most common category.
mode1= inventory['Qty_in_Unit_of_ Entry'].mode()
mode2= inventory['Qty_in_OPUn'].mode()
mode3= inventory['Qty_in_order_unit'].mode()
mode4= inventory['Amount_in_LC'].mode()
mode5= inventory['Item'].mode()
mode6= inventory['Quantity'].mode()

#SECOND BUSINESS MOMENTS
#STANDARD DEVIATION
#The standard deviation is the square root of the variance, providing a measure of the average distance of each data point from the mean.
stddev1= inventory['Qty_in_Unit_of_ Entry'].std()
stddev2= inventory['Qty_in_OPUn'].std()
stddev3= inventory['Qty_in_order_unit'].std()
stddev4= inventory['Amount_in_LC'].std()
stddev5= inventory['Item'].std()
stddev6= inventory['Quantity'].std()

#VARIANCE
#A higher variance indicates that the data points are spread out from the mean, while a lower variance indicates that they are closer to the mean.
variance1= inventory['Qty_in_Unit_of_ Entry'].var()
variance2= inventory['Qty_in_OPUn'].var()
variance3= inventory['Qty_in_order_unit'].var()
variance4= inventory['Amount_in_LC'].var()
variance5= inventory['Item'].var()
variamce6= inventory['Quantity'].var()

#RANGE
#Important in categorical data to understand the most common category.
range1= max(inventory['Qty_in_Unit_of_ Entry']) - min(inventory['Qty_in_Unit_of_ Entry'])
range2= max(inventory['Qty_in_OPUn']) - min(inventory['Qty_in_OPUn'])
range3= max(inventory['Qty_in_order_unit']) - min(inventory['Qty_in_order_unit'])
range4= max(inventory['Amount_in_LC']) - min(inventory['Amount_in_LC'])
range5= max(inventory['Item']) - min(inventory['Item'])
range6= max(inventory['Quantity']) - min(inventory['Quantity'])

#THIRD BUSINESS MOMENT
#SKEWNESS
#Skewness measures the asymmetry of the data distribution
#choice of summary statistics (e.g., mean vs. median) and the type of transformations needed.
skew1= inventory['Qty_in_Unit_of_ Entry'].skew()
skew2= inventory['Qty_in_OPUn'].skew()
skew3= inventory['Qty_in_order_unit'].skew()
skew4= inventory['Amount_in_LC'].skew()
skew5= inventory['Item'].skew()
skew6= inventory['Quantity'].skew()

#FOURTH BUSINESS MOMENT
#KURTOSIS
kurt1= inventory['Qty_in_Unit_of_ Entry'].kurt()
kurt2= inventory['Qty_in_OPUn'].kurt()
kurt3= inventory['Qty_in_order_unit'].kurt()
kurt4= inventory['Amount_in_LC'].kurt()
kurt5= inventory['Item'].kurt()
kurt6= inventory['Quantity'].kurt()



#DATA PREPROCESSING,DATA CLEANING
#TYPE CASTING
#Changing the data type of columns during type casting is crucial for memory efficiency, computational performance, data integrity, compatibility with libraries, and preparation for machine learning.
#Ensuring that each column has the appropriate data type allows for more accurate, efficient, and error-free data analysis and modeling.
inventory.dtypes

inventory['Material_Description'] = inventory['Material_Description'].astype(str)
inventory['Posting_Date'] = pd.to_datetime(inventory['Posting_Date'], format='%d-%m-%Y')
inventory['Document_Date'] = pd.to_datetime(inventory['Document_Date'], format='%d-%m-%Y')
inventory['Entry_Date'] = pd.to_datetime(inventory['Entry_Date'], format='%d-%m-%Y')
inventory['Time_of_Entry'] = pd.to_datetime(inventory['Time_of_Entry'], format='%H:%M:%S').dt.time
inventory['Qty_in_Unit_of_ Entry'] = inventory['Qty_in_Unit_of_ Entry'].astype(int)
inventory['Order'] = inventory['Order'].astype(int)
inventory['Qty_in_OPUn'] = inventory['Qty_in_OPUn'].astype(int)
inventory['Qty_in_order_unit'] = inventory['Qty_in_order_unit'].astype(int)
inventory['Amount_in_LC'] = inventory['Amount_in_LC'].astype(int)
inventory['Purchase_Order'] = inventory['Purchase_Order'].astype(int)
inventory['Cost_Center_Encoded'] = inventory['Cost_Center_Encoded'].astype(int)
inventory['Supplier'] = inventory['Supplier'].astype(int)
inventory['Quantity'] = inventory['Quantity'].astype(int)
inventory['Vendor_Code'] = inventory['Vendor_Code'].astype(int)
inventory['Username'] = inventory['Username'].astype(int)

#IDENTIFYING DUPLICATE RECORDS 
dup= inventory.duplicated()        #NO DUPLICATE RECORDS FOUND

#OUTLIER TREATMENT
#Outliers are typically associated with numerical data, so the first step is to narrow down your focus to columns that contain numerical values 
inventory.dtypes

#CREATING BOX PLOT TO VISUALISE DISTRIBUTION OF POTENTIAL OUTLIERS IN Qty_in_Unit_of_ Entry
sns.boxplot(x=inventory['Qty_in_Unit_of_ Entry'])
plt.title('Boxplot of Qty_in_Unit_of_Entry')
plt.xlabel('Qty_in_Unit_of_Entry')
plt.show()                                          #OUTLIERS PRESENT

#CREATING BOX PLOT TO VISUALISE DISTRIBUTION OF POTENTIAL OUTLIERS IN Amount_in_LC 
sns.boxplot(x=inventory['Amount_in_LC'])
plt.title('Amount_in_LC')
plt.xlabel('Amount_in_LC')
plt.show()                                          #OUTLIERS PRESENT

#OUTLIER TREATMENT,TRIMMING TECHNIQUE, FLAGGING OUTLIERS
#Qty_in_Unit_of_ Entry 
IQR= inventory['Qty_in_Unit_of_ Entry'].quantile(0.75) - inventory['Qty_in_Unit_of_ Entry'].quantile(0.25)
lower_limit = inventory['Qty_in_Unit_of_ Entry'].quantile(0.25) - (IQR * 1.5)
upper_limit = inventory['Qty_in_Unit_of_ Entry'].quantile(0.75) + (IQR * 1.5)

#Creating a boolean array indicating whether each value in the column is an outlier
outliers1= np.where(inventory['Qty_in_Unit_of_ Entry'] > upper_limit, True, np.where(inventory['Qty_in_Unit_of_ Entry'] < lower_limit, True, False))


#Filtering the DataFrame to include only rows where column contains outliers
invent_out = inventory.loc[outliers1, ]

# Filtering the DataFrame to exclude rows containing outliers
invent_trimmed = inventory.loc[~(outliers1), ]

inventory.shape, invent_trimmed.shape
sns.boxplot(x=invent_trimmed['Qty_in_Unit_of_ Entry'])
plt.title('Boxplot of Qty_in_Unit_of_ Entry')
plt.xlabel('Qty_in_Unit_of_ Entry')
plt.show()



#OUTLIER TREATMENT,TRIMMING TECHNIQUE, FLAGGING OUTLIERS
#Amount_in_LC
IQR= inventory['Amount_in_LC'].quantile(0.75) - inventory['Amount_in_LC'].quantile(0.25)
lower_limit = inventory['Amount_in_LC'].quantile(0.25) - (IQR * 1.5)
upper_limit = inventory['Amount_in_LC'].quantile(0.75) + (IQR * 1.5)

#Creating a boolean array indicating whether each value in the column is an outlier
outliers2= np.where(inventory['Amount_in_LC'] > upper_limit, True, np.where(inventory['Amount_in_LC'] < lower_limit, True, False))


#Filtering the DataFrame to include only rows where column contains outliers
invent_out2 = inventory.loc[outliers2, ]

# Filtering the DataFrame to exclude rows containing outliers
invento_trimmed = inventory.loc[~(outliers2), ]

inventory.shape, invento_trimmed.shape
sns.boxplot(x=invento_trimmed['Amount_in_LC'])
plt.title('Boxplot of Amount_in_LC')
plt.xlabel('Amount_in_LC')
plt.show()

#REPLACING OUTLIERS BY MAX AND MIN LIMIT
#CREATING A NEW COLUMN "INVENT_REPLACED" IN DATARAME WITH VALUES REPLACED BY UPPER AND LOWER LIMIT IF THERE ARE OUTLIERS
inventory['invent_replaced'] = pd.DataFrame(np.where(inventory['Qty_in_Unit_of_ Entry'] > upper_limit, upper_limit, np.where(inventory['Qty_in_Unit_of_ Entry'] < lower_limit, lower_limit, inventory['Qty_in_Unit_of_ Entry'])))
sns.boxplot(inventory.invent_replaced)

inventory['invento_replaced'] = pd.DataFrame(np.where(inventory['Amount_in_LC'] > upper_limit, upper_limit, np.where(inventory['Amount_in_LC'] < lower_limit, lower_limit, inventory['Amount_in_LC'])))
sns.boxplot(inventory.invento_replaced)


#ZERO VARIANCE & NEAR ZERO VARIANCE
#IF VARIANCE IS LOW OR CLOSE TO O, THEN A FEATURE IS APPROXIMATELY CONSTANT & WINT IMPROVE PERFORMANCE OF MODEL
#IN THAT CASE IT SHOULD BE REMOVED
numeric_columns= inventory.select_dtypes(include=np.number)
numeric_columns.var()           

#CHECKING IF VARIANCE OF EACH NUMERIC VARIABLE IS EQUAL TO 0, ALSO ALONG COLUMNS & RETURNING BOOLEAN DATATYPE
numeric_columns.var() == 0 
numeric_columns.var(axis=0) == 0 


#DUMMY VARIABLES
inventory.info()
unique_values = inventory.nunique()

columns_to_drop = ['Ext_Amount_in_Local_Currency','Sales_Value','Sales_Order_Schedule','Sales_Order_Item','Consumption','Sales_Value_inc_VAT','Original_Line_Item']
inventory.drop(columns=columns_to_drop, inplace=True)   #Modify the dataframe directly using inplace command


#MISSING VALUES
inventory.isna().sum()
from sklearn.impute import SimpleImputer

# Creating an imputer object that fills 'Nan' values
# Mean and Median imputer are used for numeric data (Order,Cost Center, Supplier)
# Mode is used for discrete data (Storage Location, Reference, Order Price Unit, Movement Indicator, Vendor Code)

skew7= inventory['Order'].skew()             #positively skewed
skew8= inventory['Cost_Center'].skew()       #positively skewed
skew9= inventory['Supplier'].skew()          #negatively skewed

#using MEDIAN IMPUTER for positive and negative skewed columns
median_imputer = SimpleImputer(missing_values=np.nan, strategy='median')
inventory["Order"] = pd.DataFrame(median_imputer.fit_transform(inventory[["Order"]]))
inventory["Cost_Center"] = pd.DataFrame(median_imputer2.fit_transform(inventory[["Cost_Center"]]))
inventory["Supplier"] = pd.DataFrame(median_imputer3.fit_transform(inventory[["Supplier"]]))
inventory.isna().sum()             # Checking for any remaining missing values


#using MODE IMPUTER
#The strategy parameter defines the method used to replace missing values. 
#If not specified,SimpleImputer defaults to the mean strategy, which might not be appropriate for all types of data.
#By explicitly setting strategy='most_frequent', you tell SimpleImputer to use the most frequent value (mode) for imputation
mode_imputer = SimpleImputer(missing_values=np.nan, strategy='most_frequent')
inventory["Storage_Location"] = pd.DataFrame(mode_imputer.fit_transform(inventory[["Storage_Location"]]))
inventory["Reference"] = pd.DataFrame(mode_imputer.fit_transform(inventory[["Reference"]]))
inventory["Order_Price_Unit"] = pd.DataFrame(mode_imputer.fit_transform(inventory[["Order_Price_Unit"]]))
inventory["Movement_indicator"] = pd.DataFrame(mode_imputer.fit_transform(inventory[["Movement_indicator"]]))
inventory["Vendor_Code"] = pd.DataFrame(mode_imputer.fit_transform(inventory[["Vendor_Code"]]))
inventory["Supplier"] = pd.DataFrame(mode_imputer.fit_transform(inventory[["Supplier"]]))
inventory["Purchase_Order"] = pd.DataFrame(mode_imputer.fit_transform(inventory[["Purchase_Order"]]))
inventory.isna().sum()
unique_values = inventory.nunique()

#KNN(K nearest neighbour) IMPUTATION FOR PURCHASE ORDER COLUMN
#uses information from similar records to fill in the missing values,which can be beneficial given the large number of unique values and the significant proportion of missing data.
#high % of missing values and unique values, so mean, median, mode cant be applied
from sklearn.impute import KNNImputer
inventory['Purchase_Order_Codes'] = inventory['Purchase_Order'].astype('category').cat.codes
purchase_order_map = dict(enumerate(inventory['Purchase_Order'].astype('category').cat.categories))
inventory= inventory.drop('Purchase_Order_Codes', axis=1)
#leaving this column as it is



#Choosing Between LABEL ENCODING and ONE HOT ENCODING
#LABEL ENCODING when the categories have meaningful order among the categories,small number of unique values.(e.g., low, medium, high).
#ONE HOT ENCODING when the categories are purely nominal and have no ordinal relationship

#Plant
inventory.info()
unique_values = inventory.nunique()
from sklearn.preprocessing import LabelEncoder
label_encoder= LabelEncoder()
inventory['Plant_Encoded'] = label_encoder.fit_transform(inventory['Plant'])
inventory.drop(columns=['Plant'], inplace=True)

#Unit_of_Entry
inventory['Unit_of_Entry_Encoded'] = label_encoder.fit_transform(inventory['Unit_of_Entry'])
inventory.drop(columns=['Unit_of_Entry'], inplace=True)

#Movement_Type_Text
inventory['Movement_Type_Text_Encoded'] = label_encoder.fit_transform(inventory['Movement_Type_Text'])
inventory.drop(columns=['Movement_Type_Text'], inplace=True)

#Order_Price_Unit
inventory['Order_Price_Unit_Encoded'] = label_encoder.fit_transform(inventory['Order_Price_Unit'])
inventory.drop(columns=['Order_Price_Unit'], inplace=True)

#Movement_indicator
inventory['Movement_indicator_Encoded'] = label_encoder.fit_transform(inventory['Movement_indicator'])
inventory.drop(columns=['Movement_indicator'], inplace=True)

#Debit_Credit_ind
inventory['Debit_Credit_ind_Encoded'] = label_encoder.fit_transform(inventory['Debit_Credit_ind'])
inventory.drop(columns=['Debit_Credit_ind'], inplace=True)

#Trans_Event_Type
inventory['Trans_Event_Type_Encoded'] = label_encoder.fit_transform(inventory['Trans_Event_Type'])
inventory.drop(columns=['Trans_Event_Type'], inplace=True)

#Base_Unit_of_Measure 
inventory['Base_Unit_of_Measure_Encoded'] = label_encoder.fit_transform(inventory['Base_Unit_of_Measure'])
inventory.drop(columns=['Base_Unit_of_Measure'], inplace=True)

#Material_Doc_Year
inventory['Material_Doc_Year_Encoded'] = label_encoder.fit_transform(inventory['Material_Doc_Year'])
inventory.drop(columns=['Material_Doc_Year'], inplace=True)

#Currency
inventory['Currency_Encoded'] = label_encoder.fit_transform(inventory['Currency'])
inventory.drop(columns=['Currency'], inplace=True)

#Material_Type
inventory['Material_Type_Encoded'] = label_encoder.fit_transform(inventory['Material_Type'])
inventory.drop(columns=['Material_Type'], inplace=True)

#Storage_Location
inventory['Storage_Location_Encoded'] = label_encoder.fit_transform(inventory['Storage_Location'])
inventory.drop(columns=['Storage_Location'], inplace=True)

#Username
inventory['Username_Encoded'] = label_encoder.fit_transform(inventory['Username'])
inventory.drop(columns=['Username'], inplace=True)

#Cost_Center
inventory['Cost_Center_Encoded'] = label_encoder.fit_transform(inventory['Cost_Center'])
inventory.drop(columns=['Cost_Center'], inplace=True)


#STANDARDIZATION & NORMALIZATION
#Standard Scaling, Min-Max, Robust Scaling works with only numerical data
#techniques used to rescale data so that it can be processed more effectively by machine learning algorithms.
inventory.info()
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
standardized_data = scaler.fit_transform(inventory)

from sklearn.preprocessing import MinMaxScaler
minmaxscale = MinMaxScaler()
inventory_minmax = minmaxscale.fit_transform(inventory)

from sklearn.preprocessing import RobustScaler
robust_model = RobustScaler()
inventory_robust = robust_model.fit_transform(inventory)


#AUTO EDA
 #It involves using tools or libraries that automate the process of exploring and understanding data.

pip install sweetviz
import sweetviz as sv
import pandas as pd

sweet = pd.read_csv(r'C:/Namit/Project 1-Pharmaceutical Inventory Management/Data Set/Book1.csv')

report = sv.analyze(sweet)
report.show_html('report.html')
