# reshape2 package
# 데이터의 형태를 바꿀 수 있어요!
# 가로로 되어 있는 데이터를 세로로 바꿀 수 있어요!
# 컬럼으로 저장되어 있는 데이터를 row형태로 
# row형태의 데이터를 column형태로 전환

# 이해를 돕기 위해 2개의 sample file을 이용해
# 보아요

# melt_mpg.csv
# sample_mpg.csv

sample_mpg <- read.csv(file="C:/R_Lecture/data/sample_mpg.csv",
                       sep=",",
                       header=T,
                       fileEncoding = "UTF-8")

sample_mpg

melt_sample_mpg <- read.csv(file="C:/R_Lecture/data/melt_mpg.csv",
                            sep=",",
                            header=T,
                            fileEncoding = "UTF-8")

View(melt_sample_mpg)

# 두 개의 data frame에 대해서 평균 도시 연비
library(ggplot2)
library(stringr)
library(dplyr)

sample_mpg      
mean(sample_mpg$cty) # 18.25

melt_sample_mpg      # 18.25
melt_sample_mpg %>% 
  filter(variable == "cty") %>%
  summarise(avg_rate = mean(value))
  
# 두 개의 data frame에 대해서 평균 연비를 구해서
# 표시 ( 평균 연비 = 도시연비와 고속도로 연비의 평균으로 계산 )
sample_mpg 
sample_mpg %>%
  mutate(avg_rate = (cty+hwy)/2)

melt_sample_mpg  # 너무 힘들어요!!

### reshape2 package는 수집한 데이터를
### 분석하기 편한 형태로 가공할 때 사용하는
### 대표적인 package

### 2개의 함수만 잘 알아두면 되요!!
# 1. melt()

# column을 row형태로 바꾸어서 가로로 긴 데이터를
# 세로로 길게 전환하는 함수
# melt()의 기본동작은 numeric을 포함하고 있는
# 모든 column을 row로 변환해요!

# 간단한 예를 통해서 melt()의 동작방식을 
# 알아보아요!
install.packages("reshape2")
library(reshape2)

# 기본적으로 R이 내장하고 있는 data set
help(airquality)  # document
airquality    
ls(airquality)    # column명
head(airquality)
str(airquality)

df <- airquality  # 원본은 건들지 말아요!!

head(df)         # 153행, 6열
melt(df)         # 
nrow(melt(df))   # 153 * 6 = 918행

nrow(melt(df, na.rm=T))  # 874행. 결측치를 제외

melt(df, id.vars="Month") # 153 * 5 = 765행
melt(df, id.vars=c("Month","Day")) 

melt_df <- melt(df, id.vars=c("Month","Day"),
           measure.vars="Ozone",
           variable.name = "Item",
           value.name = "Item_value") 

melt_df
# dcast() : data frame에 대한 cast작업
# row로 되어 있는 데이터를 column형태로 전환

dcast(melt_df,
      formula=Month ~ Item,
      fun=mean,
      na.rm=T)

## 처음에 받은 csv파일의 내용을 원상복귀시켜보아요!!
melt_sample_mpg

dcast(melt_sample_mpg,
      formula=manufacturer +
        model + class + trans + year ~ variable,
      value.var = "value")

## 제공된 파일을 이용한 melt 형식의 data frame은
## 원상복귀 될 수 없어요!

## melt()된 데이터를 생성해 보아요!
## mpg를 가지고 melt data set를 생성해 보아요!
df <- as.data.frame(mpg)
head(df)
audi_df <- df %>%
           filter(manufacturer == "audi",
                  model == "a4")
audi_df

melt_audi_df <- melt(audi_df,
                     id.vars=c("manufacturer",
                               "model",
                               "year",
                               "cyl",
                               "trans"),
                     measure.vars=c("displ",
                                    "cty",
                                    "hwy"))
            
melt_audi_df

dcast(melt_audi_df,
      formula=manufacturer +
        model + year + cyl + trans ~ variable,
      value.var = "value")


