import requests
from decouple import config

url = 'https://translation.googleapis.com/language/translate/v2'
key = config('GOOGLE_TOKEN')
# google token도 .env에 추가하기
data = {
    'q': '엄마판다는 새끼가 있네',
    'source': 'ko',
    'target': 'vn'
}
result = requests.post(f'{url}?key={key}',data).json()
print(result)