
# ggplot2 package의 mpg data 활용

install.packages("ggplot2")
library(ggplot2)
library(dplyr)

mpg = as.data.frame(mpg)   # mpg data frame

View(mpg)
help(mpg)    # mpg data set reference

# 주요컬럼
# manufacturer : 제조회사
# displ : 배기량
# cyl : 실린더 개수
# drv : 구동 방식
# hwy : 고속도로 연비
# class : 자동차 종류
# model : 자동차 모델명
# year : 생산연도
# trans : 변속기 종류
# cty : 도시 연비
# fl : 연료 종류

# 기본연습문제
# 모든 차량에 대해 평균 도시 연비보다 도시 연비가
# 높은 차량의 model명을 출력하세요
df <- mpg
df
avg_cty <- mean(mpg$cty); avg_cty
new_df <- filter(df,
                 cty > avg_cty)
head(new_df)
unique(new_df$model)

# 고속도로 연비가 상위 75% 이상인 차량을 제조하는
# 제조사는 몇개인지 추출하세요
length(unique(filter(df,
       hwy >= summary(df$hwy)[5])$manufacturer))

# 오토 차량 중 배기량(displ)이 2500cc 이상인 차량의 수는 
# 몇개 인가요?
library(stringr)
nrow(filter(df,
       str_detect(trans,"auto"),
       displ >= 2.5))

# 모든 차량에 대해 평균 도시 연비보다 도시연비가 
# 높은 차량의 model명을 출력하세요. 단,
# 모델명을 오름차순으로 정렬하세요.
df %>% filter(cty >= mean(cty)) %>% 
       select(model) %>%
       unique() %>%
       arrange(model)

# model이 a4이고 배기량이 2000CC 이상인 차들에 대해
# 평균 연비를 계산하세요
result <- df %>% 
          filter(model == "a4",
                 displ >= 2.0) %>%
          mutate(avg_rate = (cty+hwy)/2) %>%
          select(avg_rate)
mean(result$avg_rate)


df %>% filter(model == "a4",
              displ >= 2.0) %>%
       summarise(avg_rate = mean(c(cty,hwy)))

#########################################################
# 연습문제
install.packages("ggplot2")
library(ggplot2)
library(dplyr)
df = as.data.frame(mpg)   # mpg data frame

# 1. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 
# 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 확인하세요.

df %>% mutate(tmp=ifelse(displ <= 4, "LOWER4",
                         ifelse(displ >=5,"UPPER5","NONE"))) %>%
       group_by(tmp) %>%
       summarise(avg_hwy = mean(hwy)) %>%
       as.data.frame() %>%
       filter(tmp != "NONE")
        
# 2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 한다. 
#    "audi"와 "toyota" 중 어느 manufacturer(제조회사)의 cty(도시 연비)가 
#    평균적으로 더 높은지 확인하세요.
df %>% filter(manufacturer == "audi" | manufacturer == "toyota") %>%
       group_by(manufacturer) %>%
       summarise(avg_rate = mean(cty))
       
       
# 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 한다. 
#    이 회사들의 데이터를 추출한 후 hwy(고속도로 연비) 전체 평균을 구하세요.
df %>% filter(manufacturer == "chevrolet" | 
              manufacturer == "ford" | 
              manufacturer == "honda") %>%
       summarise(avg_hwy = mean(hwy))  

# 4. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 
#    알아보려고 한다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 
#    데이터를 출력하세요.
df %>% filter(manufacturer == "audi") %>%
       arrange(desc(hwy)) %>%
       head(5)


# 5. mpg 데이터는 연비를 나타내는 변수가 2개입니다. 두 변수를 각각 활용하는 대신 
#    하나의 통합 연비 변수를 만들어 사용하려 합니다. 
#    평균 연비 변수는 두 연비(고속도로와 도시)의 평균을 이용합니다. 
#    회사별로 "suv" 자동차의 평균 연비를 구한후 내림차순으로 정렬한 후 1~5위까지 
#    데이터를 출력하세요.
df %>% filter(class == "suv") %>%
       group_by(manufacturer) %>%
       summarise(avg_rate = mean(c(cty,hwy))) %>%
       arrange(desc(avg_rate)) %>%
       head(5)

# 6. mpg 데이터의 class는 "suv", "compact" 등 자동차의 특징에 따라 일곱 종류로 분류한
#    변수입니다. 어떤 차종의 도시 연비가 높은지 비교하려 합니다. 
#    class별 cty 평균을 구하고 cty 평균이 높은 순으로 정렬해 출력하세요.
df %>% group_by(class) %>%
       summarise(avg_cty = mean(cty)) %>%
       arrange(desc(avg_cty))  


# 7. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려 합니다. 
#    hwy(고속도로 연비) 평균이 가장 높은 회사 세 곳을 출력하세요.
df %>% group_by(manufacturer) %>%
       summarise(avg_hwy = mean(hwy)) %>%
       arrange(desc(avg_hwy)) %>%
       head(3)


# 8. 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 합니다. 
#    각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

df %>% filter(class == "compact") %>%
       group_by(manufacturer) %>%
       summarise(n_compact = n()) %>%
       arrange(desc(n_compact))   

##########################################################

# MovieLens DataSet 활용
install.packages("xlsx")
library(xlsx)
library(dplyr)

# data frame 생성
ratings <- read.csv(file.choose(),
                    fileEncoding = "UTF-8")

str(ratings)
sum(is.na(ratings))   # NA(결측치가 포함되어 있는지 확인)
head(ratings)

movies <- read.csv(file.choose(),
                   fileEncoding = "UTF-8",
                   stringsAsFactors = FALSE)

str(movies)
sum(is.na(movies))   # NA(결측치가 포함되어 있는지 확인)
head(movies)

# 1. 사용자가 평가한 모든 영화의 전체 평균 평점
mean(ratings$rating)

# 2. 각 사용자별 평균 평점
df <- ratings %>%
      group_by(userId) %>%
      summarise(mean=mean(rating))

class(df)
df = as.data.frame(df)

dim(df)   # 610 2
head(df,3)
tail(df,3)

# 3. 각 영화별 평균 평점
df <- ratings %>%
      group_by(movieId) %>%
      summarise(mean=mean(rating))

class(df)
df = as.data.frame(df)
dim(df)   # 9724 2
head(df,3)
tail(df,3)

# 4. 평균 평점이 가장 높은 영화의 제목을 내림차순으로
#    정렬해서 출력
#    ( 동률이 있을 경우 모두 출력)
ratings <- read.csv("C:/R_workspace/R_Lecture/data/MovieLens/ratings.csv",
                    encoding = "UTF-8")

movies <- read.csv("C:/R_workspace/R_Lecture/data/MovieLens/movies.csv",
                   encoding = "UTF-8",
                   stringsAsFactors = FALSE,
                   sep=",")
df <- ratings %>%
      group_by(movieId) %>%
      summarise(mean=mean(rating)) %>%
      filter(mean == max(mean)) %>%
      left_join(movies, by="movieId") %>%
      arrange(desc(title)) %>%
      filter(!is.na(title)) %>%
      filter(!is.na(genres))
df
head(df,3)
tail(df,3)
sum(is.na(df))
View(df)


# 5. Comedy영화 중 가장 평점이 낮은 영화의 제목
ratings <- read.csv("C:/R_workspace/R_Lecture/data/MovieLens/ratings.csv",
                    encoding = "UTF-8")

movies <- read.csv("C:/R_workspace/R_Lecture/data/MovieLens/movies.csv",
                   encoding = "UTF-8",
                   stringsAsFactors = FALSE,
                   sep=",")
library(stringr)

df <- movies %>%
      mutate(comedy = str_detect(genres,"Comedy")) %>%
      filter(comedy == T) %>%
      left_join(ratings,by="movieId") %>%
      select(c("movieId","title","rating")) %>%
      group_by(movieId) %>%
      summarise(avg=mean(rating, na.rm=T)) %>%
      as.data.frame() %>%
      filter(!is.nan(avg)) %>%
      filter(avg == min(avg)) %>%
      inner_join(movies, by="movieId") %>%
      select("title") %>% arrange(title)
df


# 6. 2015년도에 평가된 모든 Romance 영화의 평균 평점은?
ratings <- read.csv("C:/R_workspace/R_Lecture/data/MovieLens/ratings.csv",
                    encoding = "UTF-8")

movies <- read.csv("C:/R_workspace/R_Lecture/data/MovieLens/movies.csv",
                   encoding = "UTF-8",
                   stringsAsFactors = FALSE,
                   sep=",")
library(stringr)

start_date = as.numeric(as.POSIXct("2015-01-01 0:0:1 EST")); start_date
end_date = as.numeric(as.POSIXct("2015-12-31 23:59:59 EST")); end_date

df <- ratings %>%
      filter(timestamp >= start_date,
             timestamp <= end_date) %>%
      left_join(movies, by ="movieId") %>%
      filter(str_detect(genres,"Romance")) %>%
      summarise(avg_rating=mean(rating))
      

##########################################################
