extends "res://scripts/Dino.gd"

func _ready():
	self.direccion = 2
	self.distancia = 3
	fixed = true
	pass
	
func win():
	get_tree().get_root().get_node("game").win()
