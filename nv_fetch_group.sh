curl -sk -X POST --compressed -H "X-Auth-Apikey: <API USER>:<API KEY>" -H "Content-Type: application/json"  -d '{
  "groups": [
    "nv.helm-canary.demo",
    "nv.redis-master.demo",
    "nv.redis-slave.demo"	     
  ],
  "policy_mode": "Protect"
}' "https://NVControllerRestAPIEndpoiny:10443/v1/file/group" -o crd.yaml
