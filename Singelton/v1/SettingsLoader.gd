class_name SettingsLoader 
extends Resource

func LoadSettings(setting_name : String):
	var dict = _LoadAndVerifyFile(setting_name)
	if !dict: return
	else : return dict

func LoadResources(res_name : String):
	var dict = _LoadAndVerifyFile(res_name)
	if !dict: return 
	return _TscnLoader(dict)

func _LoadAndVerifyFile(file_name : String):
	var settings_folder = DirAccess.open("res://Settings/")
	var files : Array = settings_folder.get_files()
	
	var formatted_name_lst = []
	for file in files:
		formatted_name_lst.append(file.split(".")[0])
	
	if file_name not in formatted_name_lst:
		printerr("SETTINGSLOADER : FILE NOT FOUND '%s'" % file_name)
		return
	
	var file_path := "res://Settings/%s.json" % file_name
	var json_as_text := FileAccess.get_file_as_string(file_path)
	var json_as_dict : Dictionary = JSON.parse_string(json_as_text)
	
	return json_as_dict

func _TscnLoader(dict : Dictionary):
	var new_dict : Dictionary
	for tscn in dict:
		if str(dict[tscn]).split(".")[-1] == "tscn":
			new_dict.merge({tscn : load(dict[tscn])})
		else :
			new_dict.merge({tscn : dict[tscn]})
	return new_dict
