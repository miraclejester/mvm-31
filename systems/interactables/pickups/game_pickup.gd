extends Area2D
class_name GamePickup

@onready var behaviour_parent: Node = %PickupBehaviour
@onready var visuals: Node2D = %Visuals

var behaviour: ActorBehaviour


func _ready() -> void:
	behaviour = behaviour_parent.get_child(0) as ActorBehaviour
	float_up()

func pickup() -> void:
	behaviour.run(0)
	queue_free()


func float_up() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(visuals, "position", visuals.position + Vector2.UP * 2, 0.5).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(float_down)


func float_down() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(visuals, "position", visuals.position + Vector2.DOWN * 2, 0.5).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(float_up)
