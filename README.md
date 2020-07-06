# Getting-and-Cleaning-Data-Course-Project

This repository contains the run_analysis.R file to create a tidy dataset from the UCI HAR dataset and then output a dataset of average measurements for each subject and activity.
The average measurements dataset will be written to the current working directory, and may be read with a call to fread(file="./AvgMeasurements.txt")

The run_analysis.R file assumes that the current working directory is initially empty, and downloads the data from the UCI HAR dataset website to a file called Data.
Next the script will unzip the file and read in the data. The data is read by creating a list of file names and indexing this list to read to the appropriate created variables.

!!!!!IF THERE ARE OTHER .txt FILES IN THE CURRENT WORKING DIRECTORY THE INDEXING WILL NOT WORK!!!!!

Please be sure to run the file from a blank current working directory.

After the the files are read in column names are added to the activity labels, then column names derived from the features are given to the x_test and x_train data.
Next, activities (in the y_test and y_train data) are appended to the test and train datasets as the first column named "Activity".
Next, more decriptive names for the activities are placed in the Activity column using the activity label data as a lookup table.
Next, the subject data derived from subject_test and subject_train are appended to the datasets as the first column named "Subjects".
Next, the test and train datasets are combined.
Next, columns containing mean and standard deviation variables are found using the grep funciton to search for column names containing "mean" or "std"
The indices of these columns are then included with the first and second columns (representing subject and activity respectively) to subset the dataset to create a final tidy dataset of initial measurements.

To derive the average measurements for each subject and activity the dataset of initial measurements is grouped by Subject and Activity, then the mean is found for all columns.
This final Averagemeasurements dataset is then written to table in the last line to appear in the working directory as AvgMeasurements.txt
