extends ActorBehaviour
class_name FlipOnInputModifierBehaviour

enum EFlipperMod {
	RecoverLastFlip,
	FlipOnCurrentInput
}

@export var flipper: Node2DFlipOnInput
@export var operation: EFlipperMod

func run(_delta: float) -> void:
	match operation:
		EFlipperMod.RecoverLastFlip:
			flipper.recover_last_flip()
		EFlipperMod.FlipOnCurrentInput:
			flipper.run(0)
