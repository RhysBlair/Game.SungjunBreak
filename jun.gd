extends CharacterBody2D

signal buff

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var jumpcount = Data.maxjump
var screensize = Vector2(1080,720)
var timecount = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$AnimatedSprite2D.animation = "jump"
		
	if is_on_floor():
		$AnimatedSprite2D.animation = "idle"
		jumpcount = Data.maxjump
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jumpcount > 0:
		jumpcount -= 1
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	move_and_slide()
	
func start():
	# 이 함수는 새 게임을 시작할 때 플레이어를 재설정한다.
	set_process(true)
	position = screensize / 2
	$AnimatedSprite2D.animation = "idle"
	
func die():
	# 플레이어가 죽으면 이 함수를 호출한다.
	#$AnimatedSprite2D.animation = "hurt"
	set_process(false)

func _on_area_entered(area):
	#오브젝트에 닿으면 발생하는 이벤트
	if area.is_in_group("truck"):
		die()
	if area.is_in_group("effect"):
		buff.emit()
		
	
