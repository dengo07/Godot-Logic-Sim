extends Camera2D

var is_dragging = false # Sürükleme durumu
var last_mouse_pos = Vector2.ZERO # Son fare pozisyonu
var zoom_speed = 0.1 # Zoom hızı
var min_zoom = Vector2(0.2, 0.2) # Minimum zoom seviyesi
var max_zoom = Vector2(3.0, 3.0) # Maksimum zoom seviyesi
var zoom_factor = 1.0

func _ready():
	# Kamerayı sahnenin merkezi olarak ayarla
	pass

func _input(event):
	# Fare sol tuşuna basıldığında veya bırakıldığında
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT :
		if event.pressed :
			# Sürüklemeyi başlat
			is_dragging = true
			last_mouse_pos = event.position
		else:
			# Sürüklemeyi durdur
			is_dragging = false


	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP or event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if event.pressed: # Tekerlek olayları için pressed kontrolü
				
				if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					zoom_factor = 1.0 - zoom_speed # UZAKLAS
				else:
					zoom_factor = 1.0 + zoom_speed # YAKINLAS
				# Yeni zoom seviyesini hesapla
				var new_zoom = zoom * zoom_factor
				# Zoom sınırlarını kontrol et
				new_zoom.x = clamp(new_zoom.x, min_zoom.x, max_zoom.x)
				new_zoom.y = clamp(new_zoom.y, min_zoom.y, max_zoom.y)
				# Zoom merkezini fare pozisyonuna göre ayarla
				var mouse_pos = get_global_mouse_position()
				position -= (mouse_pos - position) * (zoom - new_zoom)
				zoom = new_zoom


	# Fare hareket ettiğinde
	if event is InputEventMouseMotion and is_dragging and GateDragDropHandler.gate_drag == false:
		# Fare hareketinin farkını hesapla
		var mouse_delta = last_mouse_pos - event.position
		# Kameranın pozisyonunu güncelle (ters yönde hareket için)
		position += mouse_delta/zoom_factor
		# Son fare pozisyonunu güncelle
		last_mouse_pos = event.position
