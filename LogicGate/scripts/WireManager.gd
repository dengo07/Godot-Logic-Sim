extends Node2D

var dragging_wire: Node2D = null
var start_port: Node2D = null
var end_port: Node2D = null
var current_hovered_port: Node2D = null
var can_delete:bool = true
var wire_scene := preload("res://scenes/wire.tscn")

func _ready():
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if dragging_wire != null: # Check if dragging is active
			print("Right-click: Canceling drag")
			manuel_delete()

func _process(_delta):
	if dragging_wire and start_port:
		update_drag_position(get_global_mouse_position())

func update_drag_position(to_position: Vector2):
	if dragging_wire and start_port:
		dragging_wire.points = [start_port.global_position, to_position]
	else:
		print("Warning: update_drag_position called with null dragging_wire or start_port")

func start_dragging(from_port: Node2D):
	if from_port and from_port.is_output:
		start_port = from_port
		dragging_wire = wire_scene.instantiate()
		dragging_wire.from_port = start_port
		add_child(dragging_wire)
		print("Started dragging from port: ", from_port.name)
	else:
		print("Error: Invalid from_port or not an output port")

func end_dragging(end_point: Node2D):
	if end_point.is_full:
		manuel_delete()
		return false
		
	if dragging_wire == null:
		print("Error: end_dragging called with null dragging_wire")
		return true

	if end_point and end_point.is_output == false and end_point.is_full == false:
		
		dragging_wire.to_port = end_point
		dragging_wire.to_port.set_value(dragging_wire.from_port.value)
		dragging_wire.setup_connection()
		end_point.is_full = true
		print("Connected wire to: ", end_point.name)
	else:
		print("Failed to connect, removing wire")
		manuel_delete()
		return false

	dragging_wire = null
	start_port = null
	end_port = null

func manuel_delete():
	if can_delete:
		if dragging_wire:
			dragging_wire.queue_free()
			print("Manually deleted wire")
		dragging_wire = null
		start_port = null
		end_port = null
		

