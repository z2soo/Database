
## 자연어 처리 기능을 이용해 보아요!

## KoNLP package를 이용해요!
# Korean Natural Language Process
# 해당 패키지 안에 사전이 포함되어 있어요!
# 3가지의 사전이 포함
# 시스템 사전(28만개), 
# 세종 사전(32만개), 
# NIADic 사전(98만개)

# Java기능을 이용해요! 시스템에 JRE가
# 설치되어 있어야 해요!
# JRE를 설치를 하긴 했는데 R package가
# JRE를 찾아서 써야해요!
# JAVA_HOME 환경변수를 설정해야 해요!

# 참고로 영문 NLP => openNLP, Snowball
# package를 많이 이용

install.packages("KoNLP")
library(KoNLP)

useNIADic()

txt <- readLines("C:/R_Lecture/data/hiphop.txt", encoding = "UTF-8")

head(txt)

# 데이터가 정상적으로 들어왔어요!
# 특수문자가 포함되어 있네?? 제거해주는게
# 좋아요!

library(stringr)

# 정규표현식을 이용해서 특수문자를 모두
# 찾아서 " "으로 변환
txt <- str_replace_all(txt,"\\W"," ")
head(txt)

## 형태소를 분석할 데이터가 준비되었어요!

## 함수를 이용해서 명사만 뽑아내요!

nouns <- extractNoun(txt)
head(nouns)

# 명사를 추출해서 list형태로 저장
length(nouns)

# list형태를 vector로 변환
words <- unlist(nouns)

head(words)
length(words)

# 워드클라우드를 만들기 위해서
# 많이 등장하는 명사만 추출

wordclound <- table(words)
class(wordclound)

df = as.data.frame(wordclound,
                   stringsAsFactors = F)
View(df)
ls(df)
# 두글자 이상으로 되어있는 데이터 중 
# 빈도수가 높은 상위 20개의 단어들만 추출
# (한글자짜리는 의미가 없어요!)
library(dplyr)

word_df <- df %>%
  filter(nchar(words) >= 2) %>%
  arrange(desc(Freq)) %>%
  head(20)

# 데이터가 준비되었으니 워드클라우드를
# 만들어 보아요!
install.packages("wordcloud")
library(wordcloud)

# 워드 클라우드에서 사용할 색상에 대한
# 팔래트를 설정
# Dark2라는 색상목록에서 8개의 색상을 추출
pal <- brewer.pal(8,"Dark2")

# 워드 클라우드는 만들때마다 랜덤하게
# 만들어져요!
# 랜덤하게 생성되기 때문에 재현성을 확보
# 할 수 없어요!
# 랜덤함수의 시드값을 고정시켜서 항상
# 같은 워드 클라우드가 만들어지게 설정
set.seed(1234)

word_df
wordcloud(words=word_df$words,
          freq=word_df$Freq,
          min.freq = 2,
          max.words = 20,
          random.order = F, 
          rot.per = .3,
          scale=c(4,0.3),
          colors = pal) 

### 네이버 영화 댓글 사이트
### 특정 영화에 대한 review를
### crawling해서
### wordcloud를 작성

