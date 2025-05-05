extends Node2D

var selection_rect := Rect2()
var is_selecting := false
var is_dragging := false
var selected_nodes := []
var start_pos := Vector2()
var drag_offset := Vector2()
var node_offsets := {}
var selected_bounds := Rect2()
var copied_nodes := []

func _ready():
	set_process_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				# Seçim başlat
				start_pos = get_global_mouse_position()
				is_selecting = true
			else:
				# Seçim tamamlandı
				is_selecting = false
				select_nodes_in_rect()

		elif event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and selection_rect.has_point(get_global_mouse_position()):
				if selected_nodes.size() > 0:
					is_dragging = true
					GateDragDropHandler.gate_drag = is_dragging
					start_pos = get_global_mouse_position()
					node_offsets.clear()
					for node in selected_nodes:
						node_offsets[node] = node.global_position - start_pos
			else:
				is_dragging = false
				GateDragDropHandler.gate_drag = is_dragging

		elif event.button_index == MOUSE_BUTTON_MIDDLE and event.pressed:
			paste_nodes(get_global_mouse_position())

	elif event is InputEventKey:
		if event.is_pressed():
			if event.keycode == KEY_C and Input.is_key_pressed(KEY_CTRL):
				copy_selected_nodes()
			elif event.keycode == KEY_V and Input.is_key_pressed(KEY_CTRL):
				paste_nodes(get_global_mouse_position())
	
			elif event.keycode == KEY_DELETE:
				delete_nodes()

	

func _process(_delta):
	if is_selecting:
		var current_pos = get_global_mouse_position()
		selection_rect.position = start_pos
		selection_rect.size = current_pos - start_pos
		selection_rect = selection_rect.abs()
	elif is_dragging:
		var current_pos = get_global_mouse_position()
		var drag_delta = current_pos - start_pos
		start_pos = current_pos

		for node in selected_nodes:
			node.global_position = current_pos + node_offsets[node]

		# selected_bounds ve selection_rect'i de taşı
		selected_bounds.position += drag_delta
		selection_rect.position += drag_delta

		queue_redraw()

func select_nodes_in_rect():
	selected_nodes.clear()
	var first := true

	for node in get_tree().get_nodes_in_group("gate"):
		if selection_rect.has_point(node.global_position):
			selected_nodes.append(node)

			if first:
				selected_bounds = Rect2(node.global_position, Vector2.ZERO)
				first = false
			else:
				selected_bounds = selected_bounds.expand(node.global_position)
	# Yeniden çizim tetikle
	queue_redraw()

func copy_selected_nodes():
	copied_nodes = []
	for node in selected_nodes:
		copied_nodes.append({
			"scene": node.scene_file_path,
			"position": node.global_position
		})
	print("Copied: ", copied_nodes.size(), " node")
	
func delete_nodes():
	for node in selected_nodes:
		node.queue_free()
	
	selected_nodes.clear()
	selection_rect = Rect2()
	selected_bounds = Rect2()
	queue_redraw()
		
func paste_nodes(paste_position: Vector2):
	if copied_nodes.is_empty():
		return

	var offset = paste_position - copied_nodes[0]["position"]

	for data in copied_nodes:
		var scene = load(data["scene"])
		if scene and scene is PackedScene:
			var new_node = scene.instantiate()
			get_parent().add_child(new_node)
			new_node.global_position = data["position"] + offset
func _draw():
	# Sağ tık ile kutu çizme sırasında görünür dikdörtgen
	if is_selecting:
		draw_rect(selection_rect, Color(0.4, 0.6, 1.0, 0.3), true)  # içi dolu
		draw_rect(selection_rect, Color(0.4, 0.6, 1.0, 0.8), false) # kenar

	# Seçili node'ları kapsayan dikdörtgeni çiz
	if selected_nodes.size() > 0:
		var rect = selected_bounds.grow(100)  # Biraz genişlet, estetik için
		draw_rect(rect, Color(1, 1, 0, 0.1), true)
		draw_rect(rect, Color(1, 1, 0, 1), false)
