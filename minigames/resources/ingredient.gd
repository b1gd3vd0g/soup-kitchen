extends Resource
class_name Ingredient 

@export var name: String
@export var filepath: String
@export var quantity: int

func _init(n = "", f = "", q = 0):
	name = n
	filepath = f
	quantity = q
