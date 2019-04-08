getwd()
setwd("//Users/juliannedelia/Desktop/Taming Big Data/Homework/parkland")

list.files()

parkland_file = read.csv("parkland.csv")
head(parkland_file)

parkland_title = parkland_file$title
head(parkland_title)

# data conversion and cleaning
parkland_title = (iconv(parkland_title, "latin1", "ASCII", sub=""))
head(parkland_title)

parkland_title = gsub("&amp", " ", parkland_title)
parkland_title = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", " ", parkland_title)
parkland_title = gsub("@\\w+", " ", parkland_title)
parkland_title = gsub("[[:punct:]]", " ", parkland_title)
parkland_title = gsub("[[:digit:]]", " ", parkland_title)
parkland_title = gsub("http\\w+", " ", parkland_title)
parkland_title = gsub("[ \t]{2,}", " ", parkland_title)
parkland_title = gsub("^\\s+|\\s+$", " ", parkland_title)
head(parkland_title)

# nrc sentiment analysis
install.packages("syuzhet")
library(syuzhet)

parkland_sentiment = get_nrc_sentiment(parkland_title)
write.csv(parkland_sentiment, "parkland_sentiment.csv", fileEncoding = "UTF-8")

parkland_sentiment
summary(parkland_sentiment)
colSums(parkland_sentiment)

# Create bar plot
barplot(colSums(parkland_sentiment))
parkland_bar = barplot(colSums(parkland_sentiment))
parkland_bar


parkland_sentiment$author = parkland_file$author
col.a = parkland_sentiment$author[parkland_sentiment$fear > 1]
col.a

parkland_sentiment$title = parkland_title
parkland_sentiment$title
col.b = parkland_sentiment$title[parkland_sentiment$fear > 1]
col.b

parkland_sentiment$bio = parkland_file$user_bio
parkland_sentiment$bio
col.c = parkland_sentiment$bio[parkland_sentiment$fear > 1]
col.c

col.d = parkland_sentiment$fear[parkland_sentiment$fear > 1]
col.d

strongest_emotion = data.frame(Author = col.a, Tweet = col.b, Bio = col.c, Fear = col.d)
strongest_emotion

#write.csv(hw_df, "hw_answers.csv")

write.csv(strongest_emotion, "parkland_answers.csv")



