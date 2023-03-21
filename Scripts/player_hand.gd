extends Node3D

# This constant simbolizes how far to the left can the cards go
const MIN_PATH_PROGRESS_RATIO = 0.35
# This constant simbolizes how far to the right can the cards go
const MAX_PATH_PROGRESS_RATIO = 1
# This constant simbolizes how far a card can get to another
const MAX_DIF_BETWEEN_CARDS = 0.1

# How many cards there was on the player's hand until last frame
var last_card_count = 0

# Load card_hold scene
@export var card_holder_scene : PackedScene

# Create an handle to Path3d where cards will be placed
@onready var cards_path : Path3D = get_node("Gimble/Path3D")


# This method adds a card to the players hand
func add_card():
	# Instantiate a card_holder scene and create a handle to it
	var card_holder : PathFollow3D = card_holder_scene.instantiate()
	
	# Add the newly created card_holder to the players hand
	cards_path.add_child(card_holder)


# This method removes a card from the players hand
func remove_card():
	# Get the total number of cards in the players hand
	var card_count = cards_path.get_child_count()
	
	# if the hand has cards it will remove the last card
	if card_count > 0:
		cards_path.get_children()[card_count - 1].queue_free()


# This method distributes the players cards equally spaced in the hand
func place_cards():
	# Get the total number of cards
	var card_count = cards_path.get_child_count()
	
	# If there is exactly 1 card in the hand it will be placed centered
	if card_count == 1:
		cards_path.get_children()[0].progress_ratio = 0.5
	# If there are more cards they will be distributed equally from the center
	elif card_count > 1:
		# Calculates an equal distance between all cards
		var  distance_between_cards = (MAX_PATH_PROGRESS_RATIO - MIN_PATH_PROGRESS_RATIO) / (card_count - 1)
		
		# Limits the distance between the cards according to the constant set at the start
		if distance_between_cards > MAX_DIF_BETWEEN_CARDS:
			distance_between_cards = MAX_DIF_BETWEEN_CARDS
		
		# Calculates the position of the first card to left of the hand
		var first_card_position = 0.5 - ((distance_between_cards * (card_count - 1)) / 2)
		
		# Gets a handle to an array containing all cards
		var cards = cards_path.get_children()
		
		# Sets a tween that will interpolate the position of the cards to have a smooth transition
		var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
		# Sets the position of each card
		for i in range(card_count):
			var card_position = first_card_position + distance_between_cards * i
			tween.tween_property(cards[i], "progress_ratio", card_position, 0.1)


func _input(event):
	# Adds a card to the players hand if '+' is pressed, or removes if '-' is pressed
	if event.is_action_pressed("add_card"):
		add_card()
	if event.is_action_pressed("remove_card"):
		remove_card()


func _process(_delta):
	# Asserts that a card was added or removed during the last frame and distributes them
	var card_count = cards_path.get_child_count()
	if card_count != last_card_count:
		last_card_count = card_count
		place_cards()


func _ready():
	# Add a card to the players hand right at the start of the game
	add_card()

