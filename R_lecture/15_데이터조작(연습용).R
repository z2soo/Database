## 3주차

## 데이터 조작, 데이터 정제
## 시각화에 대한 내용(ggplot2)

## mpg data set을 이용해서 데이터 조작, 정제에 
## 대한 내용을 학습해 보아요!!

## mpg data set을 이용하기 위해서 특정 package를
## 설치해 보아요!
install.packages("ggplot2")  # package 설치
library(ggplot2)    # package를 메모리에 로딩

str(mpg)   # 자료구를 조사해 보아요!!
class(mpg) # 자료구를 조사해 보아요!!
## mpg는 table data frame 형태
## 출력을 용이하게 하기 위한 형태이고
## console 크기에 맞추어서 data frame을 출력

df <- as.data.frame(mpg)  # data frame으로 변환
df
class(df)

## 사용할 data frame을 준비했어요!!
## data frame의 column명을 알아보아요!!
ls(df)   # column 명을 오름차순 정렬해서 추출

## mpg에 대한 document를 확인해서 column의 의미를
## 먼저 파악해야 해요!
head(df)    # 기본적으로 6개 출력
tail(df)

head(df,3)  # 보고싶은 개수를 지정할 수 있어요!
View(df)    # View창을 통해 데이터를 확인!
dim(df)     # data frame이 몇개의 행과 몇개의
            # 열로 구성되어 있는지 확인
nrow(df)    # data frame의 행의 개수를 추출
ncol(df)    # data frame의 열의 개수를 추출
length(df)  # 원래 length()는 원소의 개수를 구하는
            # 함수인데 data frame에 적용되면
            # column의 개수를 구해요!
str(df)     # 자료구조, 행의 개수, 열의 개수
            # 컬럼명, 데이터 타입,...
summary(df) # 가장 기본적인 통계 데이터를 추출
rev()       # vector에 대해서 데이터를 역순으로
            # 변환하는 기능

############################################

## 데이터 조작 ( dplyr : 디플라이알 )
## data frame을 조작할 때 가장 많이 사용하는 
## package 
## 속도에 강점 : C++로 구현되어 있어요!
## Chaining이 가능해요 ( %>% )
## dplyr이 제공하는 여러 함수를 이용해서
## 우리가 원하는 데이터를 추출

library(dplyr)  # library를 로딩해요!

# 1. tbl_df() 
df
df <- tbl_df(df)        # table data frame
df <- as.data.frame(df) # data frame
df

# 2. rename() # column의 이름을 변경할 수 있어요
# raw data를 이용할 경우 column명이 없을때
# column명을 새로 명시해서 사용해야 해요!
# 컬럼명에 대소문자가 같이 있는 경우 
# 모두 소문자, 대문자로 변경해서 사용하면 편해요
# df의 컬럼명을 모두 소문자 혹은 대문자로 변경
# names()를 이용해서 하는게 더 편해요!
names(df) = toupper(names(df))

df
# rename()은 data frame을 리턴
new_df <- rename(df,
                 MODEL = model)    
head(new_df)

# 3. 조건을 만족하는 행을 추출하는 함수
# filter(data frame,
#        조건1, 조건2, 조건3, ... )
# mpg data set에서
# 2008년도에 생산된 차량이 몇개 있는지 추출
# 117개
df <- as.data.frame(mpg)
nrow(filter(df,
       year == 2008))
# 모든 차량에 대해 평균 도시연비보다 도시연비가
# 높은 차량의 model명을 출력하세요
# 모델명이 총 몇개예요!
# 23개
# 차량의 개수는 118개
avg_cty <- mean(df$cty, na.rm=T); avg_cty
unique(filter(df,
       cty > avg_cty)$model)
# 고속도로 연비가 상위 75% 이상인 차량을 제조
# 하는 제조사는 몇개인지 추출하세요
# 총 15개 제조사 중 9개
length(unique(filter(df,
       hwy >= summary(df$hwy)[5])$manufacturer))

# 오토 차량중 배기량이 2500cc 이상인 차량 수는
# 몇개 인가요?
# 총 234 개의 차종 중 125 개
# 문자열 처리를 해야해요!!
library(stringr)
nrow(filter(df,
       displ >= 2.5,
       str_detect(trans,"auto")))

# 4. arrange() : 정렬하는 함수
# 기본 정렬방식 : 오름차순
# arrange(data frame,
#         column1,
#         desc(column2))     


# 모든 차량에 대해 평균 도시연비보다 도시연비가
# 높은 차량의 model명을 출력하세요. 
# 단, 모델명을 오름차순으로 정렬하세요
avg_cty <- mean(df$cty, na.rm=T); avg_cty
unique(filter(df,
              cty > avg_cty)$model)

df %>% filter(cty > mean(cty)) %>%
       select(model) %>%
       unique() %>%
       arrange(model)
       
# 5. select() : data frame에서 원하는 column만
# 추출하는 함수
# select(data frame, column1, column2, ... )

# 6. 새로운 column을 생성하려면 어떻게 해야 
# 하나요?

# 도시연비와 고속도로 연비를 합쳐서 평균 연비
# column을 만들어 보아요! (mean_rate)
df$mean_rate = (df$cty + df$hwy) / 2
head(df)
# 기본 R의 기능을 이용해서 column을 만들 수 있어요!

# column을 추가할 때는 mutate()함수를 이용해요
df <- as.data.frame(mpg)
head(df)
new_df <- 
  df %>% mutate(mean_rate = (cty+hwy)/2) 
head(new_df)

# 7. 통계량을 구해서 새로운 컬럼으로 생성
# 하는 함수 : summarise()
#  
# model명이 a4이고 배기량이 2000CC 이상인 
# 차들에 대해 전체 평균 연비를 계산하세요!
result <- df %>%
          filter(model == "a4",
                 displ >= 2.0) %>%
          mutate(avg_rate = (cty+hwy)/2) %>%
          select(avg_rate)
mean(result$avg_rate)        

summary(df$hwy)
# summarise()를 이용해 보아요!
df %>% filter(model == "a4",
       displ >= 2.0) %>%
       summarise(avg_rate = mean(c(cty,hwy)))
  
ls(df)  
# 8. group_by() : 범주형 변수에 대한 grouping
df %>% filter(displ >= 2.0) %>%
  group_by(manufacturer) %>%
  summarise(avg_rate = mean(c(cty,hwy)))

# 9. left_join(), right_join(), inner_join()
#    outer_join()




























