extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$inputA.connect("value_changed",Callable(self,"_on_inputs_changed"))
	$inputB.connect("value_changed",Callable(self,"_on_inputs_changed"))
	_on_inputs_changed()


# Called every frame. 'delta' is the elapsed time since

func _on_inputs_changed(new_value = null):
	var a = $inputA.value
	var b = $inputB.value
	var result = (a and  not b) or (not a and b)
	$output.set_value(result)
	print(result)
	
