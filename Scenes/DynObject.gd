extends RigidBody2D

#@export var use_sprite2d_texture = false;
#@export var texture: Texture2D;
@export var needs_runtime_init = false;
#@export var path_to_image_texture: String; # Path to the disk resource. Is bound to GPU memory as a Texture2D at scene load.
@export var canvas_texture_resource: Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Technically, we shouldn't need to do any pre-init -- predefined DynObjs can be saved as resources
	#	and added by the scene manager!
	# TODO: implement this later for custom objects
	pass;
	
	# If the DynObject needs runtime initialisation (i.e. texture, collision needs to be set
	#	programmatically, then do the stuff
	
	# This works for a string path to an image.
	#if self.needs_runtime_init:
		#var texture = BitMap.new();
		#texture.create_from_image_alpha( Image.load_from_file( self.path_to_image_texture ) );
		#
		## Take the first polygon to use
		## FIXME: by right, we should use a convex hull of the points...
		#var polygon = texture.opaque_to_polygons( Rect2( Vector2.ZERO, texture.get_size() ) )[0];
		#
		#$"./Sprite2D".texture = Texture2D
		#$"./CollisionPolygon2D".polygon = polygon;
		
	#if self.canvas_texture_resource and typeof( self.canvas_texture_resource ) == Texture:
		#
	#else:
		## Collision polygon and sprite should have been set up
		#pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
