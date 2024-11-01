class_name SpeedUpPushZone
extends CameraControllerBase


@export var push_ratio:float = 0.9
@export var pushbox_top_left:Vector2 = Vector2(-10, 6)
@export var pushbox_bottom_right:Vector2 = Vector2(12, -6)
@export var speedup_zone_top_left:Vector2 = Vector2(-6, 4)
@export var speedup_zone_bottom_right:Vector2 = Vector2(6, -3)

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

	# inner zone logic
	var inner_left:float = speedup_zone_top_left.x + global_position.x
	var inner_right:float = speedup_zone_bottom_right.x + global_position.x
	var inner_top:float = speedup_zone_top_left.y + global_position.z
	var inner_bottom:float = speedup_zone_bottom_right.y + global_position.z
	
	if (
		target.global_position.x > inner_left
		and target.global_position.x < inner_right
		and target.global_position.z < inner_top
		and target.global_position.z > inner_bottom
	):
		super(delta)
		return
	
	#speedup zone logic
	var camera_speed:Vector3 = push_ratio * target.velocity * delta
	global_position.x += camera_speed.x
	global_position.z += camera_speed.z
	
	# outer pushbox logic
	var pushbox_left = pushbox_top_left.x + global_position.x
	var pushbox_right = pushbox_bottom_right.x + global_position.x
	var pushbox_top = pushbox_top_left.y + global_position.z
	var pushbox_bottom = pushbox_bottom_right.y + global_position.z
	
	if target.global_position.x < pushbox_left:
		global_position.x += target.global_position.x - pushbox_left
	if target.global_position.x > pushbox_right:
		global_position.x += target.global_position.x - pushbox_right
	if target.global_position.z > pushbox_top:
		global_position.z += target.global_position.z - pushbox_top
	if target.global_position.z < pushbox_bottom:
		global_position.z += target.global_position.z - pushbox_bottom
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var pushbox_left:float = pushbox_top_left.x
	var pushbox_right:float = pushbox_bottom_right.x
	var pushbox_top:float = pushbox_top_left.y
	var pushbox_bottom:float = pushbox_bottom_right.y
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_top))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_bottom))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_bottom))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_top))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_top))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	var mesh_instance_inner := MeshInstance3D.new()
	var immediate_mesh_inner := ImmediateMesh.new()
	var material_inner := ORMMaterial3D.new()
	
	mesh_instance_inner.mesh = immediate_mesh_inner
	mesh_instance_inner.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var speedup_zone_left:float = speedup_zone_top_left.x
	var speedup_zone_right:float = speedup_zone_bottom_right.x
	var speedup_zone_top:float = speedup_zone_top_left.y
	var speedup_zone_bottom:float = speedup_zone_bottom_right.y
	
	immediate_mesh_inner.surface_begin(Mesh.PRIMITIVE_LINES, material_inner)
	immediate_mesh_inner.surface_add_vertex(Vector3(speedup_zone_right, 0, speedup_zone_top))
	immediate_mesh_inner.surface_add_vertex(Vector3(speedup_zone_right, 0, speedup_zone_bottom))
	
	immediate_mesh_inner.surface_add_vertex(Vector3(speedup_zone_right, 0, speedup_zone_bottom))
	immediate_mesh_inner.surface_add_vertex(Vector3(speedup_zone_left, 0, speedup_zone_bottom))
	
	immediate_mesh_inner.surface_add_vertex(Vector3(speedup_zone_left, 0, speedup_zone_bottom))
	immediate_mesh_inner.surface_add_vertex(Vector3(speedup_zone_left, 0, speedup_zone_top))
	
	immediate_mesh_inner.surface_add_vertex(Vector3(speedup_zone_left, 0, speedup_zone_top))
	immediate_mesh_inner.surface_add_vertex(Vector3(speedup_zone_right, 0, speedup_zone_top))
	immediate_mesh_inner.surface_end()

	material_inner.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material_inner.albedo_color = Color.HOT_PINK
	
	add_child(mesh_instance)
	add_child(mesh_instance_inner)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	mesh_instance_inner.global_transform = Transform3D.IDENTITY
	mesh_instance_inner.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
	mesh_instance_inner.queue_free()
