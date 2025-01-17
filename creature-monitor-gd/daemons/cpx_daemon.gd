extends Node

var requests: Dictionary

func _init():
	requests = {}

func _process(_delta):
	for v in requests.keys():
		var req: CPXRequest = v
		if req.poll():
			requests.erase(req)

func cpx_request(purpose: String, pba: PoolByteArray) -> CPXRequest:
	var req = CPXRequest.new(purpose, pba)
	requests[req] = true
	return req

func cpx_string_request(purpose: String, text: String) -> CPXRequest:
	var pba = text.to_utf8()
	pba.push_back(0)
	return cpx_request(purpose, pba)

func caos_request(purpose: String, text: String) -> CPXRequest:
	return cpx_string_request(purpose, "execute\n" + text)
