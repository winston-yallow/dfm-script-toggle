@tool
extends EditorPlugin


var interface: EditorInterface
var current_main_screen := "2D"
var last_main_screen := ""


func _enter_tree() -> void:
	interface = get_editor_interface()
	main_screen_changed.connect(_set_main_screen)


func _exit_tree() -> void:
	if main_screen_changed.is_connected(_set_main_screen):
		main_screen_changed.disconnect(_set_main_screen)


func _set_main_screen(main_screen: String) -> void:
	current_main_screen = main_screen


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_F4:
		if interface.distraction_free_mode:
			interface.distraction_free_mode = false
			if last_main_screen != "":
				interface.set_main_screen_editor(last_main_screen)
		else:
			last_main_screen = current_main_screen
			interface.set_main_screen_editor("Script")
			interface.distraction_free_mode = true
