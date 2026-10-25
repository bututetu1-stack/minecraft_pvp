# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=stalker] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (持っていない場合のみ)
# ※ give_stalker_items と同じ短剣を返す (物理 0.01。実ダメージは trigger_attack の遅延攻撃)
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{is_stalker_weapon:1b}}}]}] run give @s minecraft:iron_sword[minecraft:custom_data={is_stalker_weapon:1b},minecraft:custom_name='{"text":"暗殺者の短剣","color":"dark_purple","italic":false}',minecraft:lore=['{"text":"非対象には威力減衰","color":"gray"}'],minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:-0.99,operation:"add_value",slot:"mainhand",id:"my_pvp:stalker_dagger_damage"}],show_in_tooltip:false},minecraft:unbreakable={}] 1

# 4. アイテム消去
kill @s