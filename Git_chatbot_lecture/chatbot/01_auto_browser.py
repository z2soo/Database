import webbrowser

# 실행시 자동으로 브라우저 실행
webbrowser.open('https://naver.com')

# 원하는 검색 리스트 작성
artists = ['민수','백예린','방탄소년단']

for artist in artists:
    webbrowser.open("https://search.naver.com/search.naver?query=" + artist)