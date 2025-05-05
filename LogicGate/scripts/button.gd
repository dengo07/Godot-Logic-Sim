extends Node2D

var value:bool = false
var can_drag:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	colour()
	$Node.set_value(self.value)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	drag_func()

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		value = !value
		$Node.set_value(self.value)
		colour()

func colour():
	if value == true:
		$MeshInstance2D.self_modulate = Color.AQUAMARINE
	elif value == false:
		$MeshInstance2D.self_modulate = Color.CORAL


func _on_drag_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				
				can_drag = true
				GateDragDropHandler.gate_drag = can_drag
			elif event.is_released():
				can_drag = false
				GateDragDropHandler.gate_drag = can_drag
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed() and Input.is_key_pressed(KEY_SHIFT):
				queue_free()
				
func drag_func():
	if can_drag:
		self.global_position = get_global_mouse_position()
	else:
		pass
