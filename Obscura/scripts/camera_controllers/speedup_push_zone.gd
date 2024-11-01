class_name SpeedUpPushZone
extends CameraControllerBase


@export var push_ratio:float
@export var pushbox_top_left:Vector2 = Vector2(-10, 6)
@export var pushbox_bottom_right:Vector2 = Vector2(10, -6)
@export var speedup_zone_top_left:Vector2 = Vector2(-8, 4)
@export var speedup_zone_bottom_right:Vector2 = Vector2(8, -4)

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
