# --- ガジェット配布 (Slot 0-3) ---
# マイクロタレット: Cost 14
item replace entity @s container.0 with minecraft:redstone_torch[minecraft:custom_data={is_gadget:1b,gadget_type:1b},minecraft:custom_name='{"text":"マイクロタレット","italic":false,"color":"gold"}',minecraft:lore=['{"text":"Cost: 14 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}']] 1

# 地雷: Cost 8
item replace entity @s container.1 with minecraft:iron_trapdoor[minecraft:custom_data={is_gadget:1b,gadget_type:2b},minecraft:custom_name='{"text":"地雷","italic":false,"color":"gray"}',minecraft:lore=['{"text":"Cost: 8 SCRAP","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']] 1

# インパクト・ランチャー: Cost 10
item replace entity @s container.2 with minecraft:piston[minecraft:custom_data={is_gadget:1b,gadget_type:3b},minecraft:custom_name='{"text":"インパクト・ランチャー","italic":false,"color":"gray"}',minecraft:lore=['{"text":"Cost: 10 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}']] 1

# 重力スネア: Cost 16
item replace entity @s container.3 with minecraft:compass[minecraft:custom_data={is_gadget:1b,gadget_type:4b},minecraft:custom_name='{"text":"重力スネア","italic":false,"color":"light_purple"}',minecraft:lore=['{"text":"Cost: 16 SCRAP","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']] 1

# --- エンジニアレンチ (Slot 4) ---
# スロット4（ホットバー5番目）に固定配布
item replace entity @s container.4 with minecraft:iron_axe[minecraft:custom_data={is_wrench:1b},minecraft:unbreakable={},minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:-100.0,operation:"add_value",slot:"mainhand",id:"my_pvp:no_damage"}],show_in_tooltip:false},minecraft:custom_name='{"text":"エンジニアレンチ","italic":false,"color":"white"}',minecraft:lore=['{"text":"右クリック: 修理 (Cost: 1)","color":"gray"}','{"text":"左クリック: 解体 (Return: 2)","color":"gray"}']] 1

# 初期スクラップ (30 -> 50)
scoreboard players set @s scrap 50

# --- キル検知用スコアの初期化 ---
# これがないと試合開始時に「キル数が増えた」と誤認され、さらに+30されてしまいます
scoreboard players operation @s last_kills = @s kills

# クールダウン初期化
scoreboard players set @s cd_turret 0
scoreboard players set @s cd_mine 0
scoreboard players set @s cd_launcher 0
scoreboard players set @s cd_snare 0