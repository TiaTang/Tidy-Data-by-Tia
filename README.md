# Tidy-Data-by-Tia

1. To start with, copy the code below to your R or RStudio to open and take a look at the final output of the submitted
"tidy_data.txt" file.

    address <- "https://s3.amazonaws.com/coursera-uploads/user-f86c8c5d3a5b0d705cfae32a/975115/asst-3/3d5d7d1046ff11e59abdf783c4321eb2.txt"
    
    address <- sub("^https", "http", address)

    tidy_data <- read.table(url(address), header = TRUE)

    View(tidy_data)

2. The code contained in run_analysis.R works even if you haven't downloaded the zip file into your directory.
If you have already downloaded and unzipped the file, please ignore the first two parts of the code and start
directly from row #11. Otherwise just run from row 1.

3. Detailed discription of the code is included in the "run_analysis.R" file. 

    a. Read corresponding files in the folder and combine the "test" files with the "train" file into dataset.

    b. Rename the variables in the dataset with names from "features.txt"

    c. Select and keep only the variables that calculates mean and std.

    d. Add in the activity column and subject column.

    e. Replace activity column content with readable discriptive words. 

    f. Summarize the mean for each column by subject and by activity.

    g. Save the new database into "tidy_data.txt"

4. At the end of the program, a new file called "tidy_data.txt" will be generated and saved into your working directory.

Enjoy!
