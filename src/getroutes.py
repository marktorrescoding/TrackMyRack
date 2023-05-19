import requests
import json
import pandas as pd
from pandas import json_normalize
from python_graphql_client import GraphqlClient

client = GraphqlClient(endpoint="https://api.openbeta.io/")

# An example to get the remaining rate limit using the Github GraphQL API.

import requests
 
query = """
query MyQuery {
  areas(filter: {area_name: {match: "X Rock"}}) {
    climbs {
      name
      grades {
        yds
      }
    }
  }
}
"""
url = 'https://api.openbeta.io/'
r = requests.post(url, json={'query': query})
print(r.status_code)
#print(r.text)

json_data = json.loads(r.text)
#print(json_data)


climbs_data = []
for area in json_data['data']['areas']:
    for climb in area['climbs']:
        climb_data = {'name': climb['name'], 'grades': climb['grades']['yds']}
        climbs_data.append(climb_data)

df = pd.DataFrame(climbs_data)
print(df)


