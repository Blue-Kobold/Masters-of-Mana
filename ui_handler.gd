extends Control

var fileDialogWindow

func _on_file_dialog_button_pressed():
	fileDialogWindow = self.find_child("FileDialog", true)
	fileDialogWindow.visible = true
	
	
func _on_file_dialog_dir_selected(dir):
	self.find_child("SelectedDir", true).text = fileDialogWindow.get_current_dir()
