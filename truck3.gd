extends RigidBody2D

func destroy():
	queue_free()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area):
	#오브젝트에 닿으면 발생하는 이벤트
	print("111")
	if area.is_in_group("trucks"):
		destroy()
		$AnimatedSprite2D.animation = "destroy()"
		
func _on_body_entered(body) -> void:
	print("수정")
	if body.is_in_group("trucks"):
		destroy()
		$AnimatedSprite2D.animation = "destroy()"
	
