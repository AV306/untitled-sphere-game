extends RigidBody2D

var shouldRespawn = false;

var grappleTargetValid: bool = false;
var grappleTarget: Vector2 = Vector2.ZERO;
var grappleStrength = 2000;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process( delta: float ) -> void:
	print( self.global_position );
	handle_movement();

func set_grapple_target( value ):
	if value != null:
		self.grappleTargetValid = true;
		self.grappleTarget = value;
		%GrappleTarget.global_position = value;
		%GrappleTarget.show();
	else:
		self.grappleTargetValid = false;
		%GrappleTarget.hide();

func handle_movement():
	# Remember target point (just once)
	if Input.is_action_just_pressed( "grapple" ):
		var queryParams = PhysicsPointQueryParameters2D.new();
		queryParams.position = get_global_mouse_position();
		
		if get_world_2d().direct_space_state.intersect_point( queryParams ).size() > 0:
			# Clicked within a valid object, target is valid
			set_grapple_target( queryParams.position );
		else:
			# Invalid click, clear target
			self.set_grapple_target( null );
	
	# Pull towards target (continuous)
	if Input.is_action_pressed( "grapple" ):
		if grappleTargetValid:
			var force = (self.grappleTarget - self.global_position).normalized() * grappleStrength;
			%StatusText.text = str( force );
			self.apply_central_force( force );
	else:
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
