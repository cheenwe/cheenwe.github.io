Sometime we may lose the replication of some volumes (disk failure or any other exception), this small script can help u dump all volumes info to csv files, and use your favorite tools to find the 'bad' volumes.


```python
import requests
from bs4 import BeautifulSoup
import json

out = file('out.csv', 'w')

# your weed master url 
url = 'http://192.64.4.35:9333/'   


s = requests.session()
res = s.get(url)
if res.status_code == 200:
    soup = BeautifulSoup(res.content, 'html.parser')
    for link in soup.find_all("a"):
        if 'index.html' not in link['href']:
            continue
        # print link['href']
        res = s.get(link['href'])
        if res.status_code == 200:
            soup = BeautifulSoup(res.content, 'html.parser')
            for volume in soup.find('tbody').find_all('tr'):
                rows = volume.find_all('td')
                # use any of your weed node, I deploy openresty before my weed cluster 
                res = s.get("http://192.xxx.xx.xx/dir/lookup?volumeId=%s&pretty=y" % rows[0].text)
                result = [a.text for a in rows[:2]]
                if res.status_code == 200:
                    json_data = res.json()
                    if 'locations' in json_data:
                        result.append(json.dumps(json_data['locations']))

                    dataline = ",".join(result)
                    print link['href'] + "," + dataline
                    out.write(link['href'] + "," + dataline)
                    out.write("\n")
```