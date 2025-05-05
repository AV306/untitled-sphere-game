extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered( body: Node2D ) -> void:
	if body.is_in_group( "RemoveOnFallOutOfWorld" ):
		print_debug( "Removed body %s" % body.name );
		$"/root/SceneRoot".remove_child( body ); # The need for "/root/SceneRoot/" pisses me off, but well :shrug:
													# Ok, apparently there exists this feature called "access as unique name",
													# but somehow I can't apply it to the root node. :(
	elif body.is_in_group( "Player" ):
		%Player.respawn();
