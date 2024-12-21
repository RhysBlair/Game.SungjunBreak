extends Node

@export var truck_scene : PackedScene

var level = 1
var score = 0
var playtime = 0
var screensize = Vector2.ZERO
var playing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_viewport().get_visible_rect().size
	$Level1/Sungjun.screensize = screensize
	#$Sungjun.hide()
	# 3초마다 트럭을 생성하는 타이머 설정
	var timer = Timer.new()
	timer.wait_time = 3.0
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))  # Callable로 수정
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	truckcreate()
	pass

func truckcreate():
	# 트럭 인스턴스 생성
	var truck = truck_scene.instantiate()
	var material: PhysicsMaterial = PhysicsMaterial.new()
	material.friction = 0
	material.bounce = 0.2
	# 물질성질을 바꿈 > 마찰력 0
	
	# 좌/우에서 무작위로 생성
	var from_left = randi() % 2 == 0
	if from_left:
		truck.position = Vector2(30, 660)  # 왼쪽에서 생성
		truck.linear_velocity = Vector2(200,0)
		truck.set_physics_material_override(material)
		truck.get_node("AnimatedSprite2D").flip_h = true
	else:
		truck.position = Vector2(screensize.x, screensize.y-100)  # 오른쪽에서 생성
		truck.linear_velocity = Vector2(-200,0)
		truck.set_physics_material_override(material)
	
	add_child(truck)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_game():
	playing = true
	level = 1
	score = 0
	playtime = 0
	$Level1/Sungjun.start()
	$Level1/Sungjun.show()
