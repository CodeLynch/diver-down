extends TextureProgressBar

@export var max_val: float = 100
@export var surface_pos_y: int = 450
@export var decrease_time: float = 30
@export var regen_time: float = 2
@onready var diver = $"../../../Diver"
@onready var diver_icon = $"../DiverIcon"
@onready var bubbles_manager = $"../../../AirBubblesManager"
var suffocation: float
var is_fading: bool

signal diver_down()

func _init() -> void:
	self.value = max_val

func _ready() -> void:
	bubbles_manager.connect("update_o2", increase_o2)

func _process(delta: float) -> void:
	if self.value > 0:
		if diver.global_position.y > surface_pos_y:
			self.value -= (max_val/decrease_time) * delta
		else:
			if self.value < max_val:
				self.value += (max_val/regen_time) * delta
		suffocation = (max_val - self.value)/max_val
		diver_icon.modulate = Color.from_hsv(0.672, suffocation, 1.0, 1.0)
	else:
		diver_down.emit()
		self.process_mode = Node.PROCESS_MODE_DISABLED

func increase_o2(amount: int) -> void:
	value = value + amount
