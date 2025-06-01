class_name Fryable extends RigidBody2D

signal fryable_cooked

@export var max_cooked = 20.0
var cooked = 0.0

func cook():
	cooked = cooked + 1
	var r = lerpf($Polygon2D.color.r, Color.BROWN.r, cooked/max_cooked)
	var g = lerpf($Polygon2D.color.g, Color.BROWN.g, cooked/max_cooked)
	var b = lerpf($Polygon2D.color.b, Color.BROWN.b, cooked/max_cooked)
	var a = lerpf($Polygon2D.color.a, Color.BROWN.a, cooked/max_cooked)
	
	$Polygon2D.color = Color(r,g,b,a)
	
	if cooked == max_cooked:
		queue_free()
		fryable_cooked.emit()
