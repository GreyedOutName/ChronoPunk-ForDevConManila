extends AudioStreamPlayer

@onready var dummy_player = AudioStreamPlayer.new()
var fading = false

func _ready() -> void:
	add_child(dummy_player)
	
	stream = load("res://Assets/sounds/music/WBA - Empty City.wav")
	self.volume_db = -30
	play()

func _process(delta: float) -> void:
	if fading:
		volume_db -= 30*delta
		dummy_player.volume_db += 30*delta
		
		if dummy_player.volume_db >= -30:
			volume_db = -30
			dummy_player.volume_db = -60
			
			stream = dummy_player.stream
			play(dummy_player.get_playback_position())
			
			dummy_player.stop()
			fading = false

func play_song(song_name) -> void:
	dummy_player.stream = load("res://Assets/sounds/music/" + song_name + ".wav")
	dummy_player.volume_db = -30
	dummy_player.play()
	
	fading = true

func play_sound(sfx_name, pitch = 1) -> void:
	dummy_player.stream = load("res://Assets/sounds/sfx/" + sfx_name + ".wav")
	dummy_player.volume_db = -30
	dummy_player.pitch_scale = pitch
	dummy_player.play()
