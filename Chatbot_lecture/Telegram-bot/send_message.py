import requests
from decouple import config

url ='http://api.telegram.org'
token = config('TELEGRAM_BOT_TOKEN')
chat_id = config('CHAT_ID')
# chat_id = requests.get(f'{url}/bot{token}/getUpdates').json()["result"][0]["message"]["from"]["id"]

# 보낼 메세지 입력받기
text = input('메세지를 입력하세요: ')
send_message = requests.get(f'{url}/bot{token}/sendMessage?chat_id={chat_id}&text={text}')

