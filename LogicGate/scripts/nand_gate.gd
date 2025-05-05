extends Node2D

var can_drag:bool = false
var needs_update := true
# Called when the node enters the scene tree for the first time.
func _ready():
	$inputA.connect("value_changed",Callable(self,"_on_inputs_changed"))
	$inputB.connect("value_changed",Callable(self,"_on_inputs_changed"))
	_on_inputs_changed()


# Called every frame. 'delta' is the elapsed time since
func _process(_delta):
	drag_func()
	if needs_update:
		update_output()
func _on_inputs_changed(_new_value = null):
	needs_update = true
	


func update_output():
	needs_update = false
	var a = $inputA.value
	var b = $inputB.value
	var result = not (a and b)
	await get_tree().create_timer(0,00000001).timeout
	$output.set_value(result)
	print(result)

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
