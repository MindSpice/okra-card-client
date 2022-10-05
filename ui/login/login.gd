extends Control
var url_auth = "https://127.0.0.1:443/auth"
var url_reg = "https://127.0.0.1:443/register"

onready var user_field = get_node("CenterContainer/VBoxContainer/user_in")
onready var pass_field = get_node("CenterContainer/VBoxContainer/pass_in")
onready var console = get_node("console")
onready var reg_console = get_node("CenterContainer/WindowDialog/VBoxContainer/reg_console")
onready var reg_user = get_node("CenterContainer/WindowDialog/VBoxContainer/reg_user_in")
onready var reg_pass = get_node("CenterContainer/WindowDialog/VBoxContainer/reg_pass_in")
var response



func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")



func _on_login_pressed():
	var login := {
	"username" : user_field.text,
	"password" : pass_field.text.sha256_text()
	}

	var query  = JSON.print(login)
	var headers = ["User-Agent: Godot-Desktop/OkraGame0.1a"]
	console.text = ""
	$HTTPRequest.request(Networking.https_auth, headers, true, HTTPClient.METHOD_POST, query)

	
func _on_request_completed(result, response_code, headers, body : PoolByteArray):
	match response_code:
		200:
			console.text = ("Login Successful")
			Networking.auth_token = body.get_string_from_utf8()
			get_tree().change_scene("res://ui/menu/menu.tscn")
		404:
			console.text = ("Invalid Login")
		201:
			reg_console.text = ("Registration successful!")
		429:
			console.text = ("Too many invalid logins, 20 minute cool down!")
		406:
			reg_console.text = ("Username already exists")
		
	
func _on_create_account_pressed():
	$CenterContainer/WindowDialog.popup_centered()
	
func _on_b_register_pressed():
	if not reg_pass.text == $CenterContainer/WindowDialog/VBoxContainer/pass_confirm.text:
		reg_console.text = "Password Mis-Match"
		return
		
	if (reg_pass.text.length() > 55 or reg_pass.text.length() < 8) :
		reg_console.text = "Password Must Be Atleast 8 Characters"
		return
		
	var reg := {
	"username" : reg_user.text,
	"password" : reg_pass.text.sha256_text()
	}
	
	var query  = JSON.print(reg)
	var headers = ["User-Agent: Godot-Desktop/OkraGame0.1a"]
	reg_console.text = ""
	$HTTPRequest.request(Networking.https_reg, headers, true, HTTPClient.METHOD_POST, query)
