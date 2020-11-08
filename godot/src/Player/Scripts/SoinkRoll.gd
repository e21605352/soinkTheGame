extends Spatial
class_name SoinkRoll

func _physics_process(delta):
	$Mesh.rotate_x(deg2rad(-10))
