extends RigidBody2D

var shouldRespawn = false;

var grappleTargetValid: bool = false;
var grappleTarget: Vector2 = Vector2.ZERO;
@export var grappleStrength = 2000; # 2000 pxN seems about right (gravity is 980 px/s^2 -> 980 pxN/kg) (pxN is N but with pixels)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process( delta: float ) -> void:
	if Input.is_key_pressed( KEY_ESCAPE ):
		self.respawn();
	#print( self.global_position );
	handle_movement();


func set_grapple_target( value ):
	if value != null:
		self.grappleTargetValid = true;
		self.grappleTarget = value;
		%GrappleTarget.global_position = value;
		#%GrapplePath.points[0] = self.global_position;
		%GrapplePath.points[1] = value;
		%GrappleTarget.show();
		%GrapplePath.show();
	else:
		self.grappleTargetValid = false;
		%GrappleTarget.hide();
		%GrapplePath.hide();


func handle_movement():
	# Remember target point (just once)
	if Input.is_action_just_pressed( "grapple" ):
		#var queryParams = PhysicsPointQueryParameters2D.new();
		var queryParams = PhysicsRayQueryParameters2D.create( self.global_position, get_global_mouse_position() );
		queryParams.exclude = [self];
		#queryParams.position = get_global_mouse_position();
		
		var result = get_world_2d().direct_space_state.intersect_ray( queryParams );
		if result.has( "position" ):
			# Clicked within a valid object, target is valid
			set_grapple_target( result.position );
		else:
			# Invalid click, clear target
			self.set_grapple_target( null );
	
	# Pull towards target (continuous)
	if Input.is_action_pressed( "grapple" ):
		if grappleTargetValid:
			var force = (self.grappleTarget - self.global_position).normalized() * grappleStrength;
			%StatusText.text = str( force );
			self.apply_central_force( force );
			%GrapplePath.points[0] = self.global_position;
	else:
		%GrapplePath.hide();
		%StatusText.text = "";


# Additional stuff to handle every physics tick
func _integrate_forces( state: PhysicsDirectBodyState2D ) -> void:
	if self.shouldRespawn:
		# Perform respawn -- incremant "attempt count" (TODO), move back to spawn anchor, reset velocity
		state.transform = Transform2D( %PlayerRespawnAnchor.transform );
		state.linear_velocity = Vector2.ZERO;
		self.shouldRespawn = false;


# Request a respawn of the player
func respawn():
	#print( "Requested player respawn" );
	%StatusText.text = "Player respawning...";
	self.shouldRespawn = true;
