extends Node

func switch_child(child: Node, new_parent: Node) -> void:
	child.get_parent().remove_child(child)
	new_parent.add_child(child)
