extends CanvasLayer

@onready var hp_margin_container: MarginContainer = $Control/HP_MarginContainer
@onready var hp_bar: TextureProgressBar = $Control/HP_MarginContainer/NinePatchRect/HP_Bar

func _ready() -> void:
	Messages.player_health_changed.connect( update_health_bar )
	pass
	
func update_health_bar( hp: float, max_hp: float ) -> void:
	var value : float = ( hp / max_hp ) * 100
	hp_bar.value = value
	hp_margin_container.size.x = max_hp + 22
	pass
