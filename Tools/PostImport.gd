@tool # Needed so it runs in editor.
extends EditorScenePostImport

# This sample changes all node names.
# Called right after the scene is imported and gets the root node.
func _post_import(scene):
	# Change all node names to "modified_[oldnodename]"
	RemoveFilter(scene)
	return scene # Remember to return the imported scene

func RemoveFilter(node):
	if not node != null: return
	if not node is Node: return
	
	var children : Array[Node] = node.find_children("*", "MeshInstance3D", true)
	
	for mesh : MeshInstance3D in children:
		var material := StandardMaterial3D.new()
		material.albedo_texture = _getTexture(mesh.name)
		material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
		mesh.material_override = material

func _getTexture(name : String) -> Texture2D:
	var path = get_source_file() + "/../"
	var dir : PackedStringArray = ResourceLoader.list_directory(path)
	for i in dir:
		if i.begins_with("tex_") : 
			return load(path + i)
	return null
