attribute @s minecraft:max_health base set 40.0
effect give @s minecraft:instant_health 1 100 true
tag @s add pending_heal

function my_pvp:system/give_gambler_items

# コイン (通常50 / 破産10 / All-In自滅0) は system/respawn で設定する
# tellraw @s {"text":"[System] ステータスが復旧しました。","color":"green"}
