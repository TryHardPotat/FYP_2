extends Panel

var time : float = 0.0
var hours : int = 0
var minutes : int = 0
var seconds : int = 0

func _process(delta):
	time += delta
	seconds = int(fmod(time, 60))
	minutes = int(fmod(time, 3600) / 60)
	hours = int(time / 3600)
	$CenterContainer/PanelContainer/HBoxContainer/Hours.text = "%02d:" % hours
	$CenterContainer/PanelContainer/HBoxContainer/Minutes.text = "%02d:" % minutes
	$CenterContainer/PanelContainer/HBoxContainer/Seconds.text = "%02d" % seconds
