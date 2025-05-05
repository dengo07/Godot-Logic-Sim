extends CanvasLayer

var And = preload("res://scenes/and_gate.tscn")
var Or = preload("res://scenes/or_gate.tscn")
var Not = preload("res://scenes/not_gate.tscn")
var Btton = preload("res://scenes/button.tscn")
var Clock = preload("res://scenes/clock.tscn")
var Nand = preload("res://scenes/nand_gate.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_and_button_pressed():
	var instance = And.instantiate()
	get_parent().add_child(instance)
	instance.global_position = get_parent().get_global_mouse_position() + Vector2(100,0)

func _on_or_button_pressed():
	var instance = Or.instantiate()
	get_parent().add_child(instance)
	instance.global_position = get_parent().get_global_mouse_position() + Vector2(100,0)

func _on_button_button_pressed():
	var instance = Btton.instantiate()
	get_parent().add_child(instance)
	instance.global_position = get_parent().get_global_mouse_position() + Vector2(100,0)


func _on_not_button_pressed():
	var instance = Not.instantiate()
	get_parent().add_child(instance)
	instance.global_position = get_parent().get_global_mouse_position() + Vector2(100,0)


func _on_clock_button_pressed():
	var instance = Clock.instantiate()
	get_parent().add_child(instance)
	instance.global_position = get_parent().get_global_mouse_position() + Vector2(100,0)




func _on_nand_button_pressed():
	var instance = Nand.instantiate()
	get_parent().add_child(instance)
	instance.global_position = get_parent().get_global_mouse_position() + Vector2(100,0)

