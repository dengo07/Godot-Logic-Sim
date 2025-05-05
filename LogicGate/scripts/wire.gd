extends Line2D

var from_port: Node2D = null
var to_port: Node2D = null
var viewport_size: Vector2i

var last_sent_value: bool = false
var is_propagating = false

func _ready():
	update_line()
	

 
	if from_port:
		from_port.connect("value_changed", Callable(self, "_on_from_value_changed"))
		# İlk değeri de aktar
		_on_from_value_changed(from_port.value)

func update_line():
	clear_points()
	colour()
	if from_port:
		add_point(from_port.global_position)
	if to_port:
		add_point(to_port.global_position)
	else:
		add_point(get_global_mouse_position()) # uç serbestken mouse’a gider

func _process(_delta):
	
	update_line() # her frame'de çizgiyi güncelle
	



func _on_from_value_changed(new_value: bool):
	if is_propagating or new_value == last_sent_value:
		return
	is_propagating = true
	last_sent_value = new_value

	update_line()
	if to_port and not to_port.is_output:
		to_port.set_value(new_value)

	is_propagating = false
		

func colour():
	if  from_port.value == true:
		self_modulate = Color.AQUAMARINE
	
	elif  from_port.value == false:
		self_modulate = Color.CORAL
		
		
func setup_connection():
	update_line()
	if from_port:
		if not from_port.is_connected("value_changed",Callable(self,"_on_from_value_changed")):
			from_port.connect("value_changed", Callable(self, "_on_from_value_changed"))
			_on_from_value_changed(from_port.value)
		
	if to_port:
		to_port.connected_wire.append(self)
		from_port.connected_wire.append(self)

func forced_deletion():
	if from_port and from_port.is_connected("value_changed", Callable(self, "_on_from_value_changed")):
		from_port.disconnect("value_changed", Callable(self, "_on_from_value_changed"))

	if to_port:
		to_port.is_full = false
		to_port.connected_wire.erase(self)
	if from_port:
		from_port.is_full = false
		from_port.connected_wire.erase(self)

	queue_free()
		
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and Input.is_key_pressed(KEY_SHIFT):
		var mouse_pos = get_global_mouse_position()
		var start = points[0]
		var end = points[1]
		var closest_point = Geometry2D.get_closest_point_to_segment(mouse_pos, start, end)
		if closest_point.distance_to(mouse_pos) < 10:
			if to_port:
				to_port.is_full = false
				forced_deletion()

