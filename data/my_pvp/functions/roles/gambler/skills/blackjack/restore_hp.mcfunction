# HP上限を戻す
# @s = player (called from gambler_main via timer)

attribute @s minecraft:generic.max_health base set 40.0
tag @s remove ignore_status_check
# tellraw @s {"text":"[System] 体力の呪縛が解けた","color":"gray"}
