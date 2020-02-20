
# R에서 Database에 연결해 보아요!
# MySQL에 연결해서 데이터를 가져올꺼예요!

# 1. MySQL DBMS를 기동 : mysqld

# 2. R에서 DBMS에 접근하려면 몇개의 package가
# 필요

# Java언어를 이용
# Java가 설치되어 있어야 해요!
# JAVA_HOME 환경변수도 잡아줘야 해요!

install.packages("rJava") # R언어에서 Java언어를 사용하기 위한 package
install.packages("RJDBC") # R언어에서 JDBC라는 기능을 이용하기 위한 package
# Java로 Database를 사용하기 위한 library
install.packages("DBI") # database를 사용하기 
# 위한 package
library(rJava)
library(RJDBC)
library(DBI)

## 필요한 package와 로딩이 끝나고

# driver가 필요
# Java언어가 Database에 접속하고 
# 사용하기 위한 기능이 들어 있는 library
# 사용하는 데이터베이스마다 설정방법이 달라요

# MySQL Driver 설정
# JAva가 Database를 접속, 이용하기 위한 설정
drv = JDBC(driverClass="com.mysql.jdbc.Driver",
           classPath="C:/R_Lecture/mysql-connector-java-5.1.48-bin.jar")

# R언어에서 Database 연결

conn <- dbConnect(drv,
                  "jdbc:mysql://localhost:3306/library",
                  "data",    # MySQL id 
                  "data")    # MySQL pw

# Query 실행 (SQL : 데이터베이스를 제어하기 위한 언어)

sql = "select * from book"  # SQL 수업때 배우세요!!

df <- dbGetQuery(conn, sql);

head(df)

View(df)

library(dplyr)

df %>% filter(bprice > 55000) %>%
  select(btitle)

#########################################

# R의 기본 & EDA (끝!!)

# ===> Python ( 로직작성... )
# => data type & data structure & 로직
# => Numpy & Pandas를 이용한 EDA
# => 통계 개념 , Python에서 처리, R에서 처리
# => 통계적 데이터 분석
# => Tensorflow를 이용한 machine learning   > AI
# => Deep Learning(CNN) 
# => R에서는 어떻게 하는지







# ===> R 샤이니 (웹 프레임웍) => python flask로 대체



