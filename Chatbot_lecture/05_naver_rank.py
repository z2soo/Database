import requests
# 네이버 순위 검색어 받아오기

import requests
from bs4 import BeautifulSoup
from datetime import datetime

url = "https://www.naver.com/"
html = requests.get(url).text
soup = BeautifulSoup(html,'html.parser')
names =soup.select("#PM_ID_ct > div.header > div.section_navbar > div.area_hotkeyword.PM_CL_realtimeKeyword_base > div.ah_roll.PM_CL_realtimeKeyword_rolling_base > div > ul > li > a > span.ah_k")
# 원래 받아온 태그는 li:nth-child(6) 였지만, 모든 랭킹을 받기 위해 li로 변경

# f string 사용하기
now = datetime.now()
print(f'{now} 기준 실시간 검색어')
for name in names:
    print(name.text)

