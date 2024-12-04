extends Camera2D

var trackSpeed = 0.5;

func _process( delta: float ) -> void:
	# I'*m guessing camera lerp goes in the per-render-frame loop...?
	# FIXME: engine-controlled damped tracking kinda "blurs" the player object
	self.position = %Player.global_position;
	#self.position = lerp( self.position, %Player.global_position, delta * 2 );
	#rint( %Player.global_position - self.position );
