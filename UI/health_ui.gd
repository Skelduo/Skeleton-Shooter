extends Control

var hearts = 4:set = set_hearts
var max_hearts = 4:set = set_max_hearts

@onready var heart_ui_empty: TextureRect = $HeartUIEmpty
@onready var heart_ui_full: TextureRect = $HeartUIFull


func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heart_ui_full != null:
		heart_ui_full.size.x = hearts * 7.5 #15 because the heart image is 15 pixel wide

func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heart_ui_empty != null:
		heart_ui_empty.size.x = max_hearts * 7.5

func _ready() -> void:
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_changed", Callable(self,"set_hearts" ))
	PlayerStats.connect("max_health_changed", Callable(self,"set_max_hearts" ))
