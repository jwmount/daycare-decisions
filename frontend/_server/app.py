from bottle import response, run, get, debug
from json import dumps

single_provider = {"id":1,"addressable_id":10,"addressable_type":"Provider","street_address":None,"locality":"BRASSALL","state":"QLD","post_code":"4305","lat":None,"long":None,"created_at":"2013-10-08T00:00:00.000Z","updated_at":"2014-04-17T19:22:57.868Z"}

providers_list = []
for i in range(0,99):
	single_provider['id'] = i
	providers_list.append(single_provider.copy())
	

@get('/providers')
def providers():
	response.content_type = 'application/json'
	return dumps(providers_list)

@get('/providers/<provider_id>')
def providers(provider_id):
    return providers_list[int(provider_id)]

# run(host='192.168.1.100', port=8080, debug=True, reloader=True)
run(host='localhost', port=8080, debug=True, reloader=True)