import os
from PIL import Image
from googleapiclient.discovery import build 
import pprint
import requests
from io import BytesIO

import argparse
parser = argparse.ArgumentParser()
parser.add_argument("input", help="input a text to image search")

args = parser.parse_args()

my_api_key = "AIzaSyDAykmLldHgBghG2abnOjwrjEfDgRI98jU"
my_cse_id = "006080186136996849614:rckq-s9yqak"

def google_search(search_term, api_key, cse_id, **kwargs):
    service = build("customsearch", "v1", developerKey=api_key)
    res = service.cse().list(q=search_term, cx=cse_id, **kwargs).execute()
    return res['items']

search_text = args.input

results = google_search(
    search_text, my_api_key, my_cse_id, num=10,searchType = "image")

for i in range(len(results)):
    #print(results[i]['pagemap'])
    try:
      	url = results[i]['link']
      	response = requests.get(url)
      	img = Image.open(BytesIO(response.content))
      	img.save(str(i)+".png")
    except:
    	print(i)
    	#print(results[i]
    	print('error')