# --- ガジェット配布 (Slot 0-3) ---
# マイクロタレット: Cost 8 -> 7
item replace entity @s container.0 with minecraft:redstone_torch{is_gadget:1b,gadget_type:1b,display:{Name:'{"text":"マイクロタレット","italic":false,"color":"gold"}',Lore:['{"text":"Cost: 7 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}']}} 1

# 地雷: Cost 5 -> 4
item replace entity @s container.1 with minecraft:iron_trapdoor{is_gadget:1b,gadget_type:2b,display:{Name:'{"text":"地雷","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 4 SCRAP","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1

# インパクト・ランチャー: Cost 6 -> 5
item replace entity @s container.2 with minecraft:piston{is_gadget:1b,gadget_type:3b,display:{Name:'{"text":"インパクト・ランチャー","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 5 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}']}} 1

# 重力スネア: Cost 9 -> 8
item replace entity @s container.3 with minecraft:compass{is_gadget:1b,gadget_type:4b,display:{Name:'{"text":"重力スネア","italic":false,"color":"light_purple"}',Lore:['{"text":"Cost: 8 SCRAP","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']}} 1

# --- エンジニアレンチ (Slot 4) ---
item replace entity @s container.4 with minecraft:iron_axe{is_wrench:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Amount:-100.0d,Operation:0,Slot:"mainhand",UUID:[I;1234,5678,9012,3456],Name:"no_damage"}],display:{Name:'{"text":"エンジニアレンチ","italic":false,"color":"white"}',Lore:['{"text":"右クリック: 修理 (Cost: 1)","color":"gray"}','{"text":"左クリック: 解体 (Return: 2)","color":"gray"}']}} 1

# 初期スクラップ
scoreboard players set @s scrap 30

# クールダウン初期化
scoreboard players set @s cd_turret 0
scoreboard players set @s cd_mine 0
scoreboard players set @s cd_launcher 0
scoreboard players set @s cd_snare 0