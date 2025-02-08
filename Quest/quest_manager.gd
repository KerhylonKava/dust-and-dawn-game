class_name QuestManager extends Node2D

#jui elements for quest infor to show on screen
@onready var QuestBox: CanvasLayer = $GameManager.get_node('QuestBox')
@onready var Background: Sprite2D = $GameManager.get_node('QuestBox').get_node('Background')
@onready var Lit_Lantern: Sprite2D = $GameManager.get_node('QuestBox').get_node('Lit_Lantern')
@onready var Unlit_Lantern: Sprite2D = $GameManager.get_node('QuestBox').get_node('Unlit_Lantern')

@export_group("Quest Settings")
@export var quest_name: String #name of quest
@export var quest_description: String #ui description text\
@export var reached_goal_text: String #ui description text after reaching goal

#all quest statuses
enum QuestStatus{
	avaliable,
	started,
	reached_goal,
	finished,
}

#quest status
@export var quest_status: QuestStatus = QuestStatus.avaliable

@export_group("Reward Settings")
@export var reward_amount: int #currency? Probably light awarded?
