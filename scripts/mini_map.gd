extends SubViewport

@onready var diver = $"../../../Diver"
@onready var minimap_cam = $Camera2D

func _ready() -> void:
	world_2d = get_tree().root.world_2d
	
func _physics_process(_delta: float) -> void:
	minimap_cam.position = diver.position
