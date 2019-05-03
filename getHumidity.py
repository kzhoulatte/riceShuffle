import requests
import json
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('city',type=str,help='city to get humidity.')

args = parser.parse_args()
city = args.city

url = 'http://api.openweathermap.org/data/2.5/weather?q={}&appid=ac7c75b9937a495021393024d0a90c44&units=metric'.format(city)

res = requests.get(url)
data = res.json()

with open('output.json','w') as f:
  json.dump(data,f)

humidity = data['main']['humidity']

with open('humidity.txt','w') as f:
    for i in range(humidity):
        f.write(city)
        f.write('\n')
