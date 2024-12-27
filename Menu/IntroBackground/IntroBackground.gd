extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var image_aspect_ratio = self.texture
	var viewport_size = get_viewport_rect().size;
	
	# Try to fit width, check if height is larger than screen
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
