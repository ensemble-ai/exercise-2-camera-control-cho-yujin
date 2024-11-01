class_name PositionLockLerp
extends CameraControllerBase


@export var follow_speed:float = 45.0
@export var catchup_speed:float = 7.0
@export var leash_distance:float = 6.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = target.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
		
	if draw_camera_logic:
		draw_logic()
		
	var global_position_no_y:Vector3 = Vector3(global_position)
	var target_position_no_y:Vector3 = Vector3(target.global_position)
	global_position_no_y.y = 0
	target_position_no_y.y = 0
	var distance:float = global_position_no_y.distance_to(target_position_no_y)
	
	var distance_to_move:float = follow_speed * delta
	if target.velocity == Vector3.ZERO:
		distance_to_move = catchup_speed * delta
		
	if (distance - distance_to_move) > leash_distance:
		distance_to_move = distance - leash_distance
		
	if distance_to_move > distance:
		distance_to_move = distance
	
	var weight:float = 0.0
	if distance != 0:
		weight = distance_to_move / distance
	 
	#print("%f: distance to move, %f: distance" % [distance_to_move, distance])
	
	var position_lock_lerp = global_position_no_y.lerp(target_position_no_y, weight)
	global_position.x = position_lock_lerp.x
	global_position.z = position_lock_lerp.z
	
	#var weight:float = follow_speed
	#if target.velocity == Vector3.ZERO:
		#weight = catchup_speed
		
	#var position_lock_lerp = global_position.lerp(target.global_position, weight)
	#global_position.x = position_lock_lerp.x
	#global_position.z = position_lock_lerp.z
	#
	#var global_position_no_y:Vector3 = Vector3(global_position)
	#global_position_no_y.y = 0
	#
	#if global_position_no_y.distance_to(target.global_position) > leash_distance:
		#var distance_to_move = global_position_no_y.distance_to(target.global_position) - leash_distance
		#var leash_weight = distance_to_move / (distance_to_move + leash_distance)
		#
		#var leash_lerp = global_position.lerp(target.global_position, leash_weight)
		#
		#global_position.x = leash_lerp.x
		#global_position.z = leash_lerp.z
	
	super(delta)
	
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-5, 0, 0))
	immediate_mesh.surface_end()
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -5))
	immediate_mesh.surface_end()
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	for n in range(0, 360):
		var circle_x = leash_distance * cos(deg_to_rad(n))
		var circle_z = leash_distance * sin(deg_to_rad(n))
		immediate_mesh.surface_add_vertex(Vector3(circle_x, 0, circle_z))
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	await get_tree().process_frame
	mesh_instance.queue_free()
