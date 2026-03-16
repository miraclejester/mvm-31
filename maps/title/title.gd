extends CanvasLayer

@onready var new_game_button: Button = %NewGame
@onready var continue_button: Button = %Continue
@onready var clicked_sfx: FmodEventEmitter2D = %ui_clicked
@onready var hover_sfx: FmodEventEmitter2D = %ui_hover

func _ready() -> void:
	AudioManager.play_bgm("Title")
	new_game_button.button_down.connect(new_game_clicked)
	continue_button.button_down.connect(continue_clicked)
	new_game_button.mouse_entered.connect(button_hovered)
	continue_button.mouse_entered.connect(button_hovered)


func execute_button(callable: Callable) -> void:
	clicked_sfx.play_one_shot()
	new_game_button.disabled = true
	continue_button.disabled = true
	new_game_button.mouse_entered.disconnect(button_hovered)
	continue_button.mouse_entered.disconnect(button_hovered)
	callable.call()


func new_game_clicked() -> void:
	execute_button(GameManager.new_game)


func continue_clicked() -> void:
	execute_button(GameManager.continue_game)


func button_hovered() -> void:
	hover_sfx.play_one_shot()
