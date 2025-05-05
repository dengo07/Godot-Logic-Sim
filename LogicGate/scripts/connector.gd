extends Node2D

var can_drag:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	drag_func()


func _on_drag_area_input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				
				can_drag = true
				GateDragDropHandler.gate_drag = can_drag
			elif event.is_released():
				can_drag = false
				GateDragDropHandler.gate_drag = can_drag
				
func drag_func():
	if can_drag:
		self.global_position = get_global_mouse_position()
	else:
		pass
