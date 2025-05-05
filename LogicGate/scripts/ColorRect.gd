extends ColorRect

# Kameranın referansını tut
@export var camera: Camera2D

func _process(delta):
	if camera and material:
		# Kameranın dünya koordinatlarındaki konumunu al
		var cam_pos = camera.global_position
		# ShaderMaterial'a camera_position olarak gönder
		var shader_material = material as ShaderMaterial
		if shader_material:
			shader_material.set_shader_parameter("camera_position", cam_pos)
		else:
			print("Error: Material is not a ShaderMaterial or not assigned")
	else:
		if not camera:
			print("Error: Camera not assigned")
		if not material:
			print("Error: Material not assigned")
