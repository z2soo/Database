from flask import Flask, render_template, request
from datetime import datetime
import random


app = Flask(__name__)

#@app.route('/') 
#def hello_world():
#    return '옴뇸뇸뇸뇨!'

@app.route('/') 
def hello_world():
    return render_template('index.html')

@app.route('/mulcam') 
def hello_world2():
    return '20층 스카이 라운지!'

@app.route('/dday')
def dday():
    today = datetime.now()
    new_year = datetime(2020, 1 ,1)
    result = new_year - today
    return f'<h1>한 살 더 먹기까지 {result.days}일 남았습니다!!</h1>'
    # day까지만 표시
    # html 태그 사용 가능

@app.route('/greeting/<string:name>')
def greeting(name):
    # return f'반갑습니다, {name}님!:)'
    return render_template('greeting.html',html_name=name)

@app.route('/cube/<int:number>')
def cube(number):
    result = number**3
    # return f'{number}의 세제곱의 값은 {number**3}입니다'
    return render_template('cube.html',number=number, result=result)

@app.route('/lunch/<int:people>')
def lunch(people):
    menu = ['보쌈수육정식','고추잡덮밥','돼지불백','샐러드','히레카츠']
    #random하여 사용자 수에 맞춰 메뉴 뽑도록 하기 
    #random 불러오기
    order = random.sample(menu, people)
    return str(order)

@app.route('/movie')
def movie():
    movies = ['나이브스 아웃','조커','앤드게임', '하이']
    return render_template('movie.html', movie_list=movies)

##네이버 같이 구현해보기1
# ping 으로 들어가서 값 입력시 pong으로 연결
@app.route('/ping')
def ping():
    return render_template('ping.html')

@app.route('/pong')
def pong():
    age=request.args.get('age')
    return render_template('pong.html',age=age)

##네이버 같이 구현해보기2
# 만든 /naver로 들어가서 값 입력시 실제 네이버로 연결 
@app.route('/naver')
def naver():
    return render_template('naver.html')

##네이버 같이 구현해보기3
@app.route('/google')
def google():
    return render_template('google.html')

##신이 나를 만들때 구현해보기
@app.route('/vonvon')
def vonvon():
    return render_template('vonvon.html')

@app.route('/godmademe')
def godmademe():
    name = request.args.get('name')
    # 데이터 리스트
    first_optoins=['순수함','기럭지','외모','귀차니즘']
    second_optoins=['똘끼','행복','재력','잘난척']
    third_optoins=['능력','과제','건망증','식욕']
    # 각 데이터 리스트들 요소를 하나씩 뽑음(랜덤)
    # random.sample은 list형태
    # random.choice는 str형태
    result1 = random.choice(first_optoins)
    result2 = random.choice(second_optoins)
    result3 = random.choice(third_optoins)
    
    return render_template('godmademe.html', name=name, result1=result1, result2=result2,result3=result3)


# app.py 가장 하단에 위치
# 앞으로 flask run으로 서버를 켜는게 아니라, pyhon app.py로 서버를 실행한다. 
# 내용이 바뀌어도 서버를 껏다 켜지 않아도 된다. 
if __name__ == '__main__':
    app.run(debug=True)