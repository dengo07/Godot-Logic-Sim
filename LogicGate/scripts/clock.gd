extends Node2D

var value:bool = false
var can_drag:bool = false
var is_active = true # Clock çalışıyorsa true
@export var  frequency = 1.0 # Saniyede kaç kez geçiş yapacak (Hz)
var time_since_last_toggle = 0.0 # Son geçişten beri geçen süre
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	drag_func()
	if is_active:
			# Geçen süreyi güncelle
			time_since_last_toggle += delta
			# Bir periyodun yarısı kadar zaman geçtiğinde durumu değiştir
			if time_since_last_toggle >= 0.5 / frequency:
				value = !value
				$Output.set_value(value)
				time_since_last_toggle = 0.0


func toggle_clock():
	# Clock'u başlat/durdur
	is_active = !is_active

func set_frequency(new_frequency):
	# Frekansı güncelle (saniyede geçiş sayısı)
	frequency = max(0.1, new_frequency) # Minimum frekans sınırı



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
