# R에서 JSON 데이터 처리

# Network을 통해서 JSON데이터를 받아서 
# Data Frame으로 만들기 위해 새로운 package를
# 이용해보아요!

# 1. package 설치
install.packages("jsonlite")
# Network관련된 package
install.packages("httr")  
# 2. package를 사용하기 위해 loading작업필요
library(jsonlite)

# 3. 문자열 처리하기 위한 package loading
library(stringr)

url <- "http://localhost:8080/bookSearch/search?keyword="

request_url <- str_c(url,
                     scan(what=character()))
# 한글처리
request_url <- URLencode(request_url) 

request_url


# 주소가 완성되었어요!!
df <- fromJSON(request_url)

df
View(df)  
str(df)   # str() : data frame의 구조를 파악
names(df) # 

# 찾은 도서 제목만 console에 출력!
for(idx in 1:nrow(df)) {
  print(df$title[idx])
}

# JSON을 이용해서 Data Frame을 생성할 수 있어요
# data frame을 csv형식으로 file에 저장

write.csv(df,
          file="C:/R_Lecture/data/book.csv",
          row.names = FALSE,
          quote = FALSE)

# Data Frame을 JSON으로 변경하려면 어떻게
# 하나요??
df_json <- toJSON(df)
df_json
prettify(df_json)

write(df_json,
      file="C:/R_Lecture/data/book_json.txt")

write(prettify(df_json),
      file="C:/R_Lecture/data/book_json.txt")

##########################################

# 2018년 10월 30일 박스오피스 순위를
# 알아내서 제목과 누적관람객수를
# CSV파일로 저장하세요!

# 얻어온 데이터에서 필요한 내용만 추출해서
# Data Frame을 새로 생성한 후 파일 출력

# Data Frame에서 로직처리(for문) 해서
# 데이터를 추출해 text 파일에 append해서 
# 파일 출력

########################################

# Web Crawling : 인터넷 상에서 필요한 정보를
# 읽어와서 수집하는 일련의 작업(과정)

# Web scraping
# => 하나의 web page에서 내가 원하는 부분을
#    추출하는 행위
# web crawling(web spidering) : 
# 자동화 봇인 crawler가 정해진 규칙에 따라
# 복수개의 web page를 browsing하는 행위

# scraping을 할 때 CSS(jQuery) selector를 
# 이용해서 필요한 정보를 추출
# selector를 이용해서 추출하기 힘든놈들도
# 있어요!
# 추가적으로 xpath도 이용해 볼 꺼예요.

# 특정 사이트에 접속해서 내가 원하는 데이터를
# 추출해보아요!!

# 1. 서버로 부터 받은 HTML 태그로 구성된
# 문자열을 자료구조화 시키는 패키지를 이용해야
# 해요!!
install.packages("rvest")
library(rvest)
library(stringr)
# 2. url을 준비해요!
url <- "https://movie.naver.com/movie/point/af/list.nhn"
page <- "page="

request_url <- str_c(url,"?",page,1)
request_url
# 3. 준비된 URL로 서버에 접속해서 HTML을 읽어온 후 자료구조화 시켜요!
html_page = read_html(request_url)
html_page
# 4. selector를 이용해서 추출하기 원하는
# 요소(element)를 선택해요!
nodes = html_nodes(html_page,"td.title > a.movie")
nodes
# 5. tag사이에 들어있는 text를 추출해요!
title <- html_text(nodes, trim = TRUE)
title

# 6. selector를 이용해서 리뷰 요소(element)
#    를 선택해요!
nodes = html_nodes(html_page,"td.title")
review <- html_text(nodes, trim = TRUE)
review

# 7. 필요없는 문자들을 제거
review = str_remove_all(review,"\t")
review = str_remove_all(review,"\n")
review = str_remove_all(review,"신고")
review

# 8. 영화제목과 리뷰에 대한 내용을 추출
df = cbind(title,review)
View(df)

# 9. 이렇게 구축한 데이터를 파일에 저장해요!

##########################################

# 이번에는 같은 작업을 xpath를 이용해서
# 처리해 보아요!!

install.packages("rvest")
library(rvest)
library(stringr)
url <- "https://movie.naver.com/movie/point/af/list.nhn"
page <- "page="
request_url <- str_c(url,"?",page,1)
html_page = read_html(request_url)
nodes = html_nodes(html_page,"td.title > a.movie")
title <- html_text(nodes, trim = TRUE)
# Review부분은 xpath로 가져와 보아요!

review = vector(mode="character", length=10)

for(idx in 1:10) {
  myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                 idx,
                 ']/td[2]/text()')
  nodes = html_nodes(html_page,
                     xpath=myPath)
  txt <- html_text(nodes, trim = TRUE)
  review[idx] = txt[3]  
}
df = cbind(title,review)
View(df)

#########################################

# 반복해서 page를 browsing하는 crawling까지
# 포함해보아요!

extract_comment <- function(idx) {
  url <- "https://movie.naver.com/movie/point/af/list.nhn"
  page <- "page="
  request_url <- str_c(url,"?",page,idx)
  html_page = read_html(request_url,
                        encoding = "CP949")
  nodes = html_nodes(html_page,"td.title > a.movie")
  title <- html_text(nodes, trim = TRUE)
  # Review부분은 xpath로 가져와 보아요!
  
  review = vector(mode="character", length=10)
  
  for(idx in 1:10) {
    myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                   idx,
                   ']/td[2]/text()')
    nodes = html_nodes(html_page,
                       xpath=myPath)
    txt <- html_text(nodes, trim = TRUE)
    review[idx] = txt[3]  
  }
  df = cbind(title,review)
  return(df)
}

### 함수를 호출해서 crawling을 해보아요!!
result_df = data.frame();
  
for(i in 1:10) {
  tmp <- extract_comment(i)
  result_df = rbind(result_df,tmp)
}

View(result_df)

#####################################

# KAKAO API(이미지검색)를 이용해서 
# 이미지를 찾고 파일로 저장해 보아요!

# 사용하는 package는
# network 연결을 통해서 서버에 접속해서
# 결과를 받아올때 일반적으로 많이 사용하는 
# package를 이용

install.packages("httr")
library(httr)
library(stringr)
# Open API의 주소를 알아야 호출하죠!!
url <- "https://dapi.kakao.com/v2/search/image"

keyword <- "query=아이유"

request_url <- str_c(url,
                     "?",
                     keyword)

request_url <- URLencode(request_url)
request_url   # API 호출 주소를 만들었어요!

# Open API를 사용할때 거의 대부분 인증절차를
# 거쳐야 사용할 수 있어요!


# Web에서 클라이언트가 서버쪽 프로그램을 
# 호출할 때 호출방식이라는게 있어요!
# GET, POST, PUT, DELETE (기본적으로 4가지 방식)
# GET, POST를 이용
# GET방식 : 서버 프로그램을 호출할 때 
#           전달 데이터를 URL뒤에 붙여서 전달
# POST방식 : 서버 프로그램을 호출할 때 
#           전달 데이터가 request header에
#           붙어서 전달
apiKey <- "40d6fc092c6c8c0aadd45424d28a2a81"
result <- GET(request_url,
              add_headers(
              Authorization=paste("KakaoAK",
                                  apiKey)))

http_status(result)  # 접속상태 결과

result_data <- content(result)  # 결과를 추출
result_data;

View(result_data)

for( i in 1:length(result_data$documents)) {
  req = result_data$documents[[i]]$thumbnail_url 
  res = GET(req)  # 이미지에 대한 응답
  # 결과로 받은 이미지를 raw형태로 추출
  imgData = content(res, "raw")  
  writeBin(imgData,
           paste("C:/R_Lecture/image/img",
           i,
           ".png")
  )
}

###########################################

# Selenium을 이용한 동적 page scraping
# Selenium을 R에서 사용할 수 있도록 도와주는
# package를 설치해야 해요!
install.packages("RSelenium")
library(RSelenium)

# R 프로그램에서 Selenium Server에 접속한 후
# remote driver객체를 return 받아요!

remDr <- remoteDriver(remoteServerAddr="localhost",
                      port=4445,
                      browserName="chrome")
remDr
# 접속이 성공하면 remote driver를 이용해서 
# chrome browser를 R code로 제어할 수 있어요!

# browser Open
remDr$open()

# open된 browser의 주소를 변경해요!
remDr$navigate("http://localhost:8080/bookSearch/index.html")

# 입력상자를 찾아요!!
inputBox <- remDr$findElement(using="css", 
                              "[type=text]")

# 찾은 입력상자에 검색어를 넣어요!
inputBox$sendKeysToElement(list("여행"))

# AJAX호출을 하기 위해 버튼을 먼저 찾아야 해요!
btn <- remDr$findElement(using="css", 
                         "[type=button]")

# 찾은 버튼에 click event를 발생
btn$clickElement()

# AJAX 호출이 발생해서 출력된 화면에서 필요한
# 내용을 추출
li_element = remDr$findElements(using="css", 
                               "li")

# 이렇게 얻어온 element 각각에 대해서 함수를 호출
myList <- sapply(li_element,function(x) {
  x$getElementText()
})

for(i in 1:length(myList)) {
  print(myList[[i]])
}









