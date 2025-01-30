extends StaticBody2D

#@export var use_polygon2d_shape = false;
@export var polygon: PackedVector2Array;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# If the Polygon2D has a pre-defined shape, copy it to the CollisionPolygon2D
	if self.polygon: #self.use_polygon2d_shape:
		$"./CollisionPolygon2D".polygon = $"./Polygon2D".polygon;
	else:
		$"./CollisionPolygon2D".polygon = self.polygon;
		$"./Polygon2D".polygon = self.polygon;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
