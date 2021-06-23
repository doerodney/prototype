import requests
from bs4 import BeautifulSoup
from bs4 import SoupStrainer

def extract_integer_value(text):
    svalue = ''.join(filter(str.isdigit, text))
    ivalue = int(svalue)
    return ivalue

def extract_direction_report(results):
    report = {}
    report['desc'] = results[0].contents[0]
    report['avg'] = int(results[1].contents[0])
    report['cur'] = extract_integer_value(results[2].contents[0])

    return report

def extract_report(results):
    report = {}
    east_bound = extract_direction_report(results[0:3])
    west_bound = extract_direction_report(results[3:6])
    
    report['east_bound'] = east_bound
    report['west_bound'] = west_bound

    return report

def main():
    page = requests.get('https://www.wsdot.com/traffic/passes/snoqualmie/default.aspx')
    only_td = SoupStrainer("td")
    soup = BeautifulSoup(page.content, 'html.parser', parse_only=only_td)
    results = soup.find_all('td')
    report = extract_report(results)
    print(report)
    

if __name__ == '__main__':
    main()
