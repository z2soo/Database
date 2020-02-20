
# R Graph
# 숫자나 문자로 표현하는 것보다는 
# 그림(그래프)으로 표현하면 변수의 관계
# 데이터 경향을 좀 더 쉽게 파악할 수 있어요!

# 해들리 위컴
# reshape2 package
# dplyr package
# ggplot2 package R에서 가장 많이 사용.

# mpg data set을 그냥 사용해 보아요!
# 산점도(scatter) - 변수간의 관계를 파악

# ggplot2는 3단계로 그래프를 그려요!
# 1. 축을 정해요! 배경을 설정
# 2. 그래프를 추가해요!
# 3. 축 범위, 배경 설정
install.packages("ggplot2")
library(ggplot2)
df <- as.data.frame(mpg)

ls(df)
# 1. 배경 설정
# data설정 : 그래프를 그리는데 필요한 데이터
# aes(x=, y=)

# 배기량에 따른 고속도로 연비
ggplot(data=df,
       aes(x=displ,
           y=hwy))

# 우리가 원하는 그래프를 그릴 
# 수 있어요
ggplot(data=df,
       aes(x=displ,
           y=hwy)) +
  geom_point()    # 산점도를 그려요

# 설정을 추가할 수 있어요!
ggplot(data=df,
       aes(x=displ,
           y=hwy)) +
  geom_point(size=3, color="red") + 
  xlim(3,5) + 
  ylim(20,30)

plot.new()  # 그린 그림을 초기화

###################################

# 막대 그래프를 그려보아요!
# 집단간의 비교를 할 때 많이 사용되요!

# 구동방식(drv) : f(전륜), r(후륜)
#                 4(4륜) 

# 연비를 비교해 보아요!

# 막대 그래프를 그리기 위해서 
# 데이터를 준비해야 해요!

# 구동방식별 고속도로 연비 차이(평균)를
# 알고 싶어요!
library(dplyr)
df <- as.data.frame(mpg)

result <-
  df %>% 
  group_by(drv) %>%
  summarise(avg_hwy=mean(hwy))

result = as.data.frame(result)

result     # 구동방식별 고속도로 연비 평균
str(result)

ggplot(data=result,
       aes(x=drv, y=avg_hwy)) + 
  geom_col()

# 막대그래프의 길이에 따라서
# 순서를 재 배치하려면

ggplot(data=result,
       aes(x=reorder(drv, -avg_hwy), 
           y=avg_hwy)) + 
  geom_col()

# 빈도 막대 그래프
# 사용하는 함수는 geom_bar()
# raw data frame을 직접 이용해서 처리
plot.new()

df <- as.data.frame(mpg)

ggplot(data=df,
       aes(x=drv)) + 
  geom_bar()

# 빈도 막대 그래프 구할 때 
# 사용하는 함수와 사용방법

head(df)

# 막대그래프 - 집단간의 비교를 할때
# 선 그래프 - 시계열 데이터를 표현
# 박스 그래프 - 데이터의 분포를 파악

# 누적 빈도 그래프

ggplot(data=df,
       aes(x=drv)) + 
  geom_bar(aes(fill=factor(class)))

# 히스토그램
# x 축이 연속형 변수이어야 해요
ggplot(data=df,
       aes(x=hwy)) + 
  geom_histogram()

##############################

# 산점도
# 막대그래프

# 선그래프(시계열 데이터)
# 일반적으로 환율, 주식, 경제동향

# mpg는 시간에 대한 데이터가 없어요
# line chart를 위해서 economics data set을 이용

economics
tail(economics)

ggplot(data=economics,
       aes(x=date,
           y=unemploy)) +
  geom_point(color="red") + 
  geom_line()
  

# 월별 개인 저축률 동향 그래프

ggplot(data=economics,
       aes(x=date,
           y=psavert)) +
  geom_line()

# 산점도 ( 변수간의 관계, 데이터 경향)
# 막대그래프
# ( 일반, 빈도(누적), 히스토그램)
# 선 그래프 ( 시계열 데이터 표현 )
# box 그래프( 데이터의 분포 )

df = as.data.frame(mpg)
head(df)

# 구동 방식별 hwy(고속도로 연비)
# 상자그림을 그려보아요!

ggplot(data=df,
       aes(x=drv,
           y=hwy)) +
  geom_boxplot()

#######################################

# 이렇게 ggplot2를 이용해서
# 4가지 종류의 그래프를 그릴 수 있어요!
# 여기에 추가적인 객체를 포함시켜서
# 그래프를 좀 더 이해하기 쉬운 형태로
# 만들어 보아요!!

# mpg : 자동차 연비에 대한 data set
# economics : 월별 경제 지표에 대한 data set

# 날짜별 개인저축률에 대한 선 그래프를 
# 그려보아요!
# 일반적인 직선을 그릴 수 있어요!

ggplot(data=economics,
       aes(x=date, y=psavert)) + 
  geom_line() + 
  geom_abline(intercept=12.1,
              slope=-0.0003444)

# 수평선을 그릴 수 있어요!

ggplot(data=economics,
       aes(x=date, y=psavert)) + 
  geom_line() + 
  geom_hline(yintercept=mean(economics$psavert))

# 수직선을 그릴 수 있어요!
# 가장 개인저축률이 낮은 날짜에 대한
# 수직선을 그릴려고 해요!

# 가장 개인저축률이 낮은 날짜를 
# economics에서 추출해 보아요!

tmp <-
economics %>% filter(psavert == min(psavert)) %>%
  select(date)

tmp <- as.data.frame(tmp)
result <- tmp$date   # 최종 날짜가 도출
  
ggplot(data=economics,
       aes(x=date, y=psavert)) + 
  geom_line() + 
  geom_vline(xintercept=result)

## 만약 직접 날짜를 직접 입력해서 수직선
## 을 표현하려면??
class(economics)
ggplot(data=economics,
       aes(x=date, y=psavert)) + 
  geom_line(size=0.1) + 
  geom_vline(xintercept=as.Date("2005-05-01"))

## 그래프 안에서 text를 표현하려면 
## 어떻게 해야 하나요??

ggplot(data=economics,
       aes(x=date, y=psavert)) + 
  geom_point() + 
  xlim(as.Date("1990-01-01"),
       as.Date("1992-12-01")) +
  ylim(7,10) +
  geom_text(aes(label=psavert,
                vjust=-0.5,
                hjust=-0.2))

### 특정 영역을 highlighting 하기 위해서
### 사용해요!


ggplot(data=economics,
       aes(x=date, y=psavert)) + 
  geom_point() +
  annotate("rect",
           xmin=as.Date("1991-01-01"),
           xmax=as.Date("2005-01-01"),
           ymin=5,
           ymax=10,
           alpha=0.3,
           fill="red")

### 여기에 추가적으로 화살표도 표현해 
### 보아요!!

ggplot(data=economics,
       aes(x=date, y=psavert)) + 
  geom_point() +
  annotate("rect",
           xmin=as.Date("1991-01-01"),
           xmax=as.Date("2005-01-01"),
           ymin=5,
           ymax=10,
           alpha=0.3,
           fill="red") + 
  annotate("segment",
           x=as.Date("1985-01-01"),
           xend=as.Date("1995-01-01"),
           y=7.5,
           yend=8.5,
           arrow=arrow(),
           color="blue") + 
  annotate("text",
           x=as.Date("1985-01-01"),
           y=15,
           label="소리없는 아우성!!") +
  labs(x="연도", y="개인별 저축률",
       title="연도별 개인저축률 추이") + 
  theme_classic()



  



