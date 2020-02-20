# 데이터 분석업무에서
# raw data를 얻은 다음
# 머신러닝 모델링을 위해서 또는 시각화를 위해서
# 이 raw data를 적절한 형태로 변형
# 데이터 변환, 필터링, 전처리 작업이 필요해요!

# 이런 작업(데이터 조작)에 특화된 package들이 존재해요
# plyr => Pliers + R => 패키지를 구현한 언어 R
# dplyr => data frame + Pliers + R (디플라이알)
# vector나 data frame에 적용할 수 있는 기본 함수

# 실습할 데이터가 필요해요!
# iris(아이리스) 

View(iris)
# iris : 붓꽃의 종류와 크기에 대해 측정한 데이터
# 통계학자 피셔라는 사람이 측정해서 제공
# 컬럼
# Species : 종(3가지)
# Sepal.Length : 꽃받침의 길이
# Sepal.Width : 꽃받침의 너비
# Petal.Length : 꽃잎의 길이
# Petal.Width : 꽃잎의 너비

# 기본함수
# 1. head() : 데이터 셋의 앞에서부터
#             6개의 데이터를 추출해요
#             데이터 프레임이 아닌경우
#             적용이 되요!
head(iris,n=1) # n의 기본값은 6
# 2. tail() : 데이터 셋의 뒤에서부터
#             6개의 데이터를 추출해요
#             데이터 프레임이 아닌경우
#             적용이 되요!
tail(iris,n=3) # n의 기본값은 6
# 3. View() : View창에 데이터를 출력
View(iris)
# 4. dim() : data frame에 적용할때
#            행과 열의 개수를 알려줘요
dim(iris)
#    선형자료구조(vector,list)에서는
#    사용할 수 없어요!
# 5. nrow() : data frame의 행의 개수
nrow(iris)
# 6. ncol() : data frame의 열의 개수
ncol(iris)
# 7. str() : data frame의 일반적인
# 정보를 추출
str(iris)
# 8. summary() : data frame의 요약 통계량을 보여줘요!
summary(iris)
# Min, Max, 사분위, 평균(mean),
# 중간값(Median)
# 9. ls() : data frame의 column명을
# vector로 추출, 오름차순으로 정렬
ls(iris)
# 10. rev() : 선형자료구조 데이터의 
#            순서를 거꾸로 만들어요
rev(ls(iris))
# 11. length() : 길이를 구하는 함수
#     data frame에 적용하면 컬럼의 개수
var1 = matrix(1:12, ncol=3)
var1
length(var1)

#################################
# plyr package => dplyr 개량형 package
install.packages("plyr")
require(plyr)  # library(plyr)

# 1. key값을 이용해서 두개의 data frame
# 을 병합( 세로방향, 열방향으로 결합)

# data frame을 두개 만들어 보아요!
x = data.frame(id=c(1,2,3,4,5),
               height=c(150,190,170,188,167))

y = data.frame(id=c(1,2,3,6),
               weight=c(50,100,80,78))

join(x,y,by="id",type="inner")
join(x,y,by="id",type="left")   # default
join(x,y,by="id",type="right")
join(x,y,by="id",type="full")

# key를 1개 이용해서 결합하는걸 해보았어요!
# key를 2개 이상이용해서 결합하는건??

x = data.frame(id=c(1,2,3,4,5),
               gender=c("M","F","M","F","M"),
               height=c(150,190,170,188,167))

y = data.frame(id=c(1,2,3,6),
               gender=c("F","F","M","F"),
               weight=c(50,100,80,78))

join(x,y,by=c("id","gender"),type="inner")

# dplyr에서는 join() => left_join()

# 2. 범주형 변수를 이용해서 그룹별 통계량
#    구하기
str(iris)
unique(iris$Species)
# iris의 종별 꽃잎 길이의 평균을 구하세요!
# tapply(대상 coulmn, 범주형 column, 적용할 함수)
# tapply는 한번의 1개의 통계만 구할 수 있어요
tapply(iris$Petal.Length,
       iris$Species,
       FUN=mean)
tapply(iris$Petal.Length,
       iris$Species,
       FUN=max)

# iris의 종별 꽃잎 길이의 평균과 표준편차를 구하세요!
# ddply() : 한번에 여러개의 통계치를 구할 수 
# 있어요!
df <- ddply(iris,
      .(Species),
      summarise,
      avg=mean(Petal.Length),
      sd=sd(Petal.Length))
class(df)
View(df)

##########################################
## plyr에서는 join()과 통계값을 구하는 함수
## (2개)만 알아두시면 되요!!

## 실제로 data frame을 핸들링할때는
## plyr을 개량한 dplyr을 이용
## dplyr은 c++로 구현되었기 때문에 속도가
## 빨라요!
## dplyr은 코딩시 chaining을 사용할 수 있어요!
install.packages("dplyr")
library(dplyr)

# fileServer : \\M1604INS
# 제공된 excel을 data set으로 이용해 보아요
install.packages("xlsx")
library(xlsx)
excel <- read.xlsx(file.choose(),
                   sheetIndex = 1,
                   encoding = "UTF-8")
excel
str(excel)
ls(excel)
# dplyr의 주요함수들
# 1. tbl_df() : 현재 console 크기에 맞추어서
# data frame을 추출하라는 함수
tbl_df(excel)

# 2. rename()
#    rename(data frame,
#           바꿀컬럼명1 = 이전컬럼명1,
#           바꿀컬럼명2 = 이전컬럼명2, ...)
# column명을 수정한 새로운 data frame이 리턴

# 제공된 excel을 읽어들여서 data frame을
# 생성한 후 column명을 보니
# AMT17 : 2017년도 이용금액
# Y17_CNT : 2017년도 이용횟수
df <- rename(excel,
             CNT17 = Y17_CNT,
             CNT16 = Y16_CNT)
df
##### data frame의 컬럼명을 바꿀 수 있어요!!

# 3. 하나의 data frame 에서 하나 이상의 조건을
# 이용해서 데이터를 추출하려면 어떻게 해야 하나요?
# filter(data frame,
#        조건1, 조건2, ...)
excel

filter(excel,
       SEX == "M" & AREA == "서울")

## 지역이 서울 혹은 경기 혹은 제주 인
## 남성들 중 40살 이상의 사람들의 정보를
## 출력하세요
filter(excel,
       AREA %in% c("서울","경기","제주"),
       SEX == "M",
       AGE >= 40)

# 4. arrange(data frame,
#            column1, desc(column2), ... )
# 정렬의 기준은 오름차순 정렬
# 만약 내림차순으로 정렬하려면 desc()

## 서울살고 남자예요.. 2017년도 처리금액이
## 400,000원 이상인 사람을 나이가 많은 순으로
## 출력하세요. (chaining 포함)
df <- filter(excel,
             AREA == "서울",
             SEX == "M",
             AMT17 >= 400000) %>%
      arrange(desc(AGE))

df

# 5. select(data frame, column1, column2,...)
# 추출하길 원하는 column을 지정해서 해당
# column만 추출할 수 있어요!

## 서울살고 남자예요.. 2017년도 처리금액이
## 400,000원 이상인 사람을 나이가 많은 순으로
## ID와 나이, 그리고 2017년도 처리 건수만
## 출력하세요. (chaining 포함)
df <- filter(excel,
             AREA == "서울",
             SEX == "M",
             AMT17 >= 400000) %>%
      arrange(desc(AGE)) %>%
      select(-SEX)
df

# 6. 새로운 column을 생성할 수 있어요!
View(excel)

# data frame의 column을 생성하는 기본기능
excel$GRADE = ifelse(excel$AMT17 >= 500000,
                     "VIP",
                     "NORMAL")
# dplyr은 새로운 column을 생성하기 위해 
# 함수를 제공
# mutate(data frame,
#        컬럼명1 = 수식1,
#        컬럼명2 = 수식2)

# 경기사는 여자를 기준으로
# 2017년도 처리금액을 이용하여 
# 처리금액의 10%를 가산한 값으로 새로운
# 컬럼 AMT17_REAL을 만들고
# AMT17_REAL이 45만원 이상인 경우
# VIP 컬럼을 만들어서 TRUE, 그렇지 않으면
# FALSE를 입력하세요
# 우리한번 만들어 보아요!!
excel

df <- filter(excel,
             AREA == "경기" & SEX == "F") %>%
      mutate(AMT17_REAL = AMT17 * 0.1 + AMT17,
             VIP = ifelse(AMT17_REAL>=450000,
                          TRUE,FALSE))
df

# 7. group_by() & summaries()
df <- filter(excel,
             AREA =="서울" & AGE > 30) %>%
      group_by(SEX) %>%
      summarise(sum=sum(AMT17), 
                cnt=n())
df

# 8. plyr package의 join 함수가
#    각 기능별로 독립적인 함수로 제공되요
# > left_join()
# > right_join()
# > inner_join()
# > full_join()

# 9. bind_rows(df1, df2)
#    주의할 점은 컬럼명이 같아야 우리가 
#    생각하는 것처럼 data frame이 결합
#    컬럼명이 같지 않으면 컬럼을 생성해서
#    결합이되요!
df1 <- data.frame(x=c("a","b","c"))
df1
df2 <- data.frame(y=c("d","e","f"))
df2
bind_rows(df1,df2)


# 조금 쉬운 연습문제를 풀어보아요!!
#
# mpg data set에 대해서 다음의 내용을 수행하세요

# 1. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 확인하세요.

#배기량 4이하 : 25.96319
#배기량 5이상 : 18.07895

# 2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 한다. "audi"와 "toyota" 중 어느 manufacturer(제조회사)의 cty(도시 연비)가 평균적으로 더 높은지 확인하세요.

# audi : 17.6
#toyota : 18.5

# 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 한다. 이 회사들의 데이터를 추출한 후 hwy(고속도로 연비) 전체 평균을 구하세요.

#hwy 전체 평균 : 22.50943

# 4. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 한다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.

#audi   a4            2.0     ~~~~~ 31
#audi   a4            2.0     ~~~~~ 30
#audi   a4            1.8     ~~~~~ 29
#audi   a4            1.8     ~~~~~ 29
#audi   a4 quattro  2.0     ~~~~~ 28

# 5. mpg 데이터는 연비를 나타내는 변수가 2개입니다. 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 사용하려 합니다. 평균 연비 변수는 두 연비(고속도로와 도시)의 평균을 이용합니다. 회사별로 "suv" 자동차의 평균 연비를 구한후 내림차순으로 정렬한 후 1~5위까지 데이터를 출력하세요.

# subaru   21.9
# toyota   16.3
# nissan    15.9
# mercury  15.6
# jeep       15.6

# 6. mpg 데이터의 class는 "suv", "compact" 등 자동차의 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교하려 합니다. class별 cty 평균을 구하고 cty 평균이 높은 순으로 정렬해 출력하세요.

# subcompact    20.4
# compact         20.1
# midsize          18.8
# minivan          15.8
# 2seater           15.4
# suv                13.5
# pickup            13


# 7. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려 합니다. hwy(고속도로 연비) 평균이 가장 높은 회사 세 곳을 출력하세요.

# honda         32.6
# volkswagen  29.2
# hyundai       26.9  

# 8. 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

# audi           15
# volkswagen  14
# toyota         12
# subaru         4
# nissan          2

#######################################
# MovieLens 연습문제를 풀어보아요!!

# MovieLens Data Set을 이용해서 처리해 보아요!
# 영화에 대한 평점 정보를 기록해 놓은 데이터
# 평점은 1점 ~ 5점 (5점이 최대)
# 사람이 한두사람이 아니예요!!
# 영화도 굉장히 많아요!
# 구글에서 MovieLens 검색

# 데이터를 받았으면 데이터의 구조 확인
# 컬럼의 의미를 파악

# 1. 사용자가 평가한 모든 영화의 전체 평균 평점
#     > 3.501557 

# 2. 각 사용자별 평균 평점
#     > 1     4.366379
#       2     3.948276
#       3     2.435897
#            ...
#       608   3.134176
#       609   3.270270
#       610   3.688556
#       총 610명 출력

# 3. 각 영화별 평균 평점
#     > 1        3.920930
#       2        3.431818
#       3        3.259615
#            ...
#       193586   3.5
#       193587   3.5
#       193609   4.0
#       총 9724행 출력


# 4. 평균 평점이 가장 높은 영화의 제목을
#    내림차순으로 정렬해서 출력
#    (동률이 있는 경우 모두 출력 )
#     총 296개의 행
#     84273      Zeitgeist: ~~
#     173351     Wow! A Talking Fish!
#     158398     World of Glory(1991)
#
#                ...
#     141816     12 Chairs (1976)
#     77846      12 Angry Men (1997)
#     27751      'Salem's Lot (2004)


# 5. comedy 영화 중 가장 평점이 낮은 영화의 
#    제목을 오름차순으로 출력 
#    (동률이 있는 경우 모두 출력 )
#    총 25개
#    Aloha (2015)
#    Are We Threr Yet? (2005)
#    Arthur Christmas (2011)
#            ...
#    Tooth Fairy 2 (2012)
#    Uncle Nino (2003)
#    Zombie Strippers! (2008)


# 6. 2015년도에 평가된 모든 Romance영화의 
#    평균 평점 출력
#    평균 평점 : 3.396375   










