extends RefCounted
class_name ActorMovementProfile

var move_method: Callable
var initialize_method: Callable
var post_move_method: Callable
var enter_method: Callable
var profile_name: String

static func from_data(dict: Dictionary) -> ActorMovementProfile:
	var res: ActorMovementProfile = ActorMovementProfile.new()
	res.move_method = dict.get("move_method")
	res.initialize_method = dict.get("initialize_method", func(): pass)
	res.post_move_method = dict.get("post_move_method", func(): pass)
	res.enter_method = dict.get("enter_method", func(): pass)
	res.profile_name = dict.get("profile_name", "Unknown")
	return res
