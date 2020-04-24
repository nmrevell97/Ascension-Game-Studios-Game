extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var score: = 1

func _on_body_entered(body: PhysicsBody2D) ->void:
		anim_player.play("fade_out")

func picked() -> void:
	PlayerData.score += score
	anim_player.play("picked")
