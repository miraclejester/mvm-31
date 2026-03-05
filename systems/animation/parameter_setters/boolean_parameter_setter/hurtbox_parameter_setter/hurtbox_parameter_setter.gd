extends BooleanParameterSetter
class_name HurtboxParameterSetter

enum EHurtboxParameter {
	Invincible
}

@export var hurtbox: Hurtbox
@export var parameter: EHurtboxParameter

func get_value() -> Variant:
	match parameter:
		EHurtboxParameter.Invincible:
			return hurtbox.invincible
		_:
			return false
