# bs 사용해서 네이버 시장지표, 환율 가져오기

# 0. 관련 모듈 import
import requests
from bs4 import BeautifulSoup

# 1. 문자열 형태로 문서 가져오기
url = "https://finance.naver.com/marketindex/"
html = requests.get(url).text

# 2. BeautifulSoup 클래스 객체 받기
soup = BeautifulSoup(html, 'html.parser')
print(type(soup))

# 3. 원하는 선택자 내용 가져오기
exchange = soup.select_one("#exchangeList > li.on > a.head.usd > div > span.value").text

# 4. 결과물 출력
print(exchange)

