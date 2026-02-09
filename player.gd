extends CharacterBody2D

const SPEED = 200
const JUMP_FORCE = -400
const GRAVITY = 900

var is_attacking = false

func _physics_process(delta):

	# tombol serang (hanya kalau di tanah)
	if Input.is_action_just_pressed("attack") and not is_attacking and is_on_floor():
		attack()

	if not is_attacking:
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

		# gerakan kiri kanan
		velocity.x = direction.x * SPEED

		# gravity
		if not is_on_floor():
			velocity.y += GRAVITY * delta

		# lompat
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_FORCE

		# menghadap arah gerak
		if direction.x != 0:
			$AnimatedSprite2D.flip_h = direction.x < 0

		# animasi
		if not is_on_floor():
			$AnimatedSprite2D.play("jump")
		elif direction.x != 0:
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("idle")

	move_and_slide()


func attack():
	is_attacking = true
	velocity.x = 0
	$AnimatedSprite2D.play("attack")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack":
		is_attacking = false
