extends CharacterBody2D

var screensize = Vector2.ZERO
var speed = 600

func destroy():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * speed * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	pass

func _on_area_entered(area):
	#오브젝트에 닿으면 발생하는 이벤트
	if area.is_in_group("truck"):
		destroy()
		$AnimatedSprite2D.animation = "destroy()"
