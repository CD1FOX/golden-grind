extends Node

var coin = 500000000000000

#Zones
var last_zone_level = 1
var current_zone_level = 1
var zone_price = 500

#Magnet Type Skill
var magnet_radius = Vector2(3.0, 3.0)
var magnet_level = 1
var magnet_cost = 10
var magnet_base_cost = 10
var magnet_skill = false
var magnet_purchase = false

#Magnet Lock Level Limits
var magnet_unlock_cost = 1000
var magnet_unlock_base_cost = 1000
var magnet_tier_list = 0
var magnet_tier_limit = 0

#Speed Type Skill
var speed = 80
var speed_cost = 10
var speed_base_cost = 10
var speed_level = 1

#Speed Lock Level Limits
var speed_unlock_cost = 500
var speed_unlock_base_cost = 500
var speed_tier_list = 0
var speed_tier_limit = 0

#Coin Value Upgrade
var coin_value = 1
var coin_value_upgrade_cost = 10
var coin_value_upgrade_base_cost = 10

#Coin Value Lock Level Limits
var coin_unlock_cost = 500
var coin_unlock_base_cost = 500
var coin_tier_list = 0
var coin_tier_limit = 0

#Auto Collector
var auto_collect = false
var auto_collect_purchase = false
var auto_collect_price = 20000

#Coin Crit Chance
var critical_chances = {
	5: 20,
	10: 10,
	50: 3,
	100: 1
}

func get_critical_multiplier():
	var roll = randf() * 100
	var cumulative = 1.0
	
	for multiplier in critical_chances.keys():
		cumulative += critical_chances[multiplier]
		if roll < cumulative:
			return multiplier
			
	return Global.coin_value

func multiplier_distributer(coin_area):
	var multiplier = get_critical_multiplier()
	var gained = coin_value * multiplier
	coin += gained
		
	if multiplier > 1:
		print("💥 CRITICAL PICKUP ×%d! +%d coins" % [multiplier, gained])
		
	coin_area.queue_free()
