extends Node2D

@export var value:bool 
@export var is_output:bool
var is_full:bool = false
var connected_wire:Array= []

signal value_changed(new_value: bool)
# Called when the node enters the scene tree for the first time.

func _ready():
	colour()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func set_value(new_value: bool):
	if new_value == value:
		return
	value = new_value
	colour()
	call_deferred("_emit_value_changed")


func colour():
	if value == true:
		$MeshInstance2D.self_modulate = Color.AQUAMARINE
	elif value == false:
		$MeshInstance2D.self_modulate = Color.CORAL



	
func _emit_value_changed():
	emit_signal("value_changed", value)




func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				if is_output:
					WireManager.start_dragging(self)
				elif not is_output and not is_full:
					var success = WireManager.end_dragging(self)
	# is_full artık sadece WireManager içinde set ediliyor, burada değil


	
	elif event is InputEventMouseMotion:
		if WireManager.dragging_wire:
			WireManager.update_drag_position(get_global_mouse_position())



func _on_area_2d_mouse_entered():
	if is_output == false and is_full ==false:
		
		WireManager.can_delete = false


func _on_area_2d_mouse_exited():
	if is_output == false:
		WireManager.can_delete = true
		
func _exit_tree():
	if connected_wire.size() >0:
		for i in connected_wire.duplicate():
			i.forced_deletion()
