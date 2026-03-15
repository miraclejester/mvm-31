extends GameWorldRoom

@export var pearl_pickup: PackedScene
@export var ending_scene: PackedScene

@onready var boss: WorldCharacter = %Boss
@onready var pearl_pos: Node2D = %PearlPosition


func _ready() -> void:
	super()
	boss.tree_exited.connect(spawn_pearl)
	OverlayEffects.fade_out_finished.connect(fade_out_finished)


func spawn_pearl() -> void:
	AudioManager.play_bgm("Beach")
	var p: Node = pearl_pickup.instantiate()
	pearl_pos.add_child(p)


func fade_out_finished() -> void:
	get_tree().change_scene_to_packed(ending_scene)
