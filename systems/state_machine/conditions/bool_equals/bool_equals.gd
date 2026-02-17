extends StateMachineCondition
class_name BoolEquals

@export var bool_retriever: BoolRetriever
@export var compared_value: bool

func evaluate() -> bool:
	return compared_value == bool_retriever.retrieve_bool()
