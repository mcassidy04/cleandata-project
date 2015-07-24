# read source data sets into distinct R objects for test and train data
tst_items<-scan("UCI HAR Dataset/test/X_test.txt",nlines=2947)
trn_items<-scan("UCI HAR Dataset/train/X_train.txt",nlines=7352)
# move data from vector to matrix
mtx1<-matrix(tst_items,nrow=2947,ncol=561)
mtx2<-matrix(trn_items,nrow=7352,ncol=561)
# establish distinct base data frames using test/train data matrices
df1<-data.frame(mtx1)
df2<-data.frame(mtx2)
rm(trn_items,tst_items,mtx1,mtx2)
require(sqldf)
# load data features list to support selection and provide column names 
df_colnames<-read.delim("UCI HAR Dataset/features.txt",col.names = c("data_col","data_label"),
                        comment.char="",header=FALSE,nrows=561,sep=" ",stringsAsFactors = FALSE)
df_shortlist<-sqldf("select data_col,data_label from df_colnames
                    where data_label like '%-mean()%'
                    or data_label like '%-std()%' order by data_col")
df_shortlist$data_label<-sapply(df_shortlist$data_label,function(x){
    splitx<-strsplit(x,"-")[[1]]
    if (length(splitx)==3){x<-paste(splitx[1],splitx[3],splitx[2],sep="-")}
    sub("-(std|mean)\\(\\)","_\\1",x)})
# select desired fields and add corresponding activity field for each record
# process each to add corresponding activity and subject field
# fields are being implicitly joined by record number across datasets
df1<-df1[,df_shortlist$data_col]
df1<-cbind(df1,scan("UCI HAR Dataset/test/y_test.txt",nlines=2947))
df1<-cbind(df1,scan("UCI HAR Dataset/test/subject_test.txt",nlines=2947))
df2<-df2[,df_shortlist$data_col]
df2<-cbind(df2,scan("UCI HAR Dataset/train/y_train.txt",nlines=7352))
df2<-cbind(df2,scan("UCI HAR Dataset/train/subject_train.txt",nlines=7352))
# apply meaningful names to data frame columns
# select column index and labels for mean and standard deviation calculation fields
names(df1)<-c(df_shortlist$data_label,"activity","subject")
names(df2)<-c(df_shortlist$data_label,"activity","subject")
# concatenate data.frame objects to create single combined data set for all subjects
df1<-rbind(df1,df2)
rm(df2)                              
# replace activity numbers with meaningful activity labels
acts<-read.delim("UCI HAR Dataset/activity_labels.txt",col.names = c("idx","activity"),
                 comment.char="",header=FALSE,nrows=6,sep=" ",stringsAsFactors = FALSE)
activity_list<-acts$activity
df1$activity<-activity_list[df1$activity]
# get means of means() and standard deviations by activity and subject
dout<-aggregate(df1[,1:66],list(activity=df1$activity,subject=df1$subject),mean)
# write to file
write.table(dout,file="run_analysis.txt",row.names = FALSE)

