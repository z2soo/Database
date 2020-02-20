from flask import Flask, render_template, request
from decouple import config
import requests, pprint, random #예쁘게 프린트
app = Flask(__name__)

# 텔레그램 API
url ='http://api.telegram.org'
token = config('TELEGRAM_BOT_TOKEN')
chat_id = config('CHAT_ID')

# 구글 API
google_url = 'https://translation.googleapis.com/language/translate/v2'
google_key = config('GOOGLE_TOKEN')

@app.route('/')
def hello_world():
    return 'Hello, World!'

# 요청의 방식 2가지: get 요청, post 요청
# get: html 페이지에 정보를 내놓으세요 요청
# post: html 페이지에 정보를 달라기 보다 추가, 삭제, 수정 요청 
# telegram 측에서 get이 아닌 post로만 받는다고 해두었기에 post 사용 
# token을 넣은 이유: 아무한테 보내는 것이 아니라 나의 토큰 정보로 보내달라고 하기 위함, 그냥 /로만 해두면 그 웹페이지에 들어오기만 해도 자동으로 메세지가 가기 때문(원하는 사람이 들어와서 메세지 보내는 동작을 했을때만 보내게끔)
# 잘 받았다고 응답할때까지 telegram에서 메세지 계속 보냄, 따라서 200: 정상적으로 처리되었다 코드를 돌려줌 
# 아래의 함수가 실행되려면 token값이 있어야 함
'''@app.route(f'/{token}',methods=['POST'])
def telegram():
    # 1. 텔레그램이 보내주는 데이터 구조 확인
    pprint.pprint(request.get_json())
    # 2. 사용자 아이디, 메세지 추출
    chat_id = request.get_json().get('message').get('chat').get('id')
    message = request.get_json().get('message').get('text')
    # 3. 텔레그램 API 요청해서 답장 보내주기
    requests.get(f'{url}/bot{token}/sendMessage?chat_id={chat_id}&text={message}')
    return '', 200
# telegram에 나의 주소 보내줘야 함, 그러나 지금 local 주소를 사용 외부에서 못봄
# 그래서 ngrok 이용'''

@app.route(f'/{token}',methods=['POST'])
def telegram():
    # 1. 사용자 아이디, 메세지 추출
    chat_id = request.get_json().get('message').get('chat').get('id')
    message = request.get_json().get('message').get('text')
    # 2. 사용자가 로또라고 입력하면 로또 번호 6개 돌려주기
    if message == '로또내놔':
        number = []
        for i in range (46):
            number.append(i)
        result = random.sample(number,6)
        requests.get(f'{url}/bot{token}/sendMessage?chat_id={chat_id}&text={result}')
    
    elif message[:4] == '/번역 ':
        data = {
            'q': message[4:],
            'source': 'ko',
            'target': 'en',
            'format': 'text'
        }
        response = requests.post(f'{google_url}?key={google_key}',data).json()
        result = response['data']['translations'][0]['translatedText']
        requests.get(f'{url}/bot{token}/sendMessage?chat_id={chat_id}&text={result}')

    # 그 외의 경우에는 메세지
    # text={message}로 하면 메아리
    else: 
        requests.get(f'{url}/bot{token}/sendMessage?chat_id={chat_id}&text=로또내놔 or /번역 번역할 말을 입력해야지 답할끄~')
    return '', 200


@app.route('/write')
def write():
    return render_template('write.html')

@app.route('/send')
def send():
    # 1. 사용자가 입력한 데이터 받아오기 (플라스크)
    message = request.args.get('message')
    # 2. 텔레그램 API 메세지 전송요청 보내기 (파이썬)
    send_message = requests.get(f'{url}/bot{token}/sendMessage?chat_id={chat_id}&text={message}')
    return '메세지 전송 완료!!'

# request: 플라스크 내부에서 서로 전송할때의 데이터를 뽑아오고자 할 때
# requests: 파이썬, 실제 외부에 있는 서버의 데이터를 가져오고자 할 때 



# 반드시 파일 최하단에 존재!!
# flask run이 아니라 python app.py를 입력하여 실행
if __name__ =='__main__':
    app.run(debug=True)