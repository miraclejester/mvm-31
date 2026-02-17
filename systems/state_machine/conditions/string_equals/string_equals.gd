extends StateMachineCondition
class_name StringEquals

@export var string_retriever: StringRetriever
@export var compared_value: String

func evaluate() -> bool:
	return compared_value == string_retriever.retrieve_string()
