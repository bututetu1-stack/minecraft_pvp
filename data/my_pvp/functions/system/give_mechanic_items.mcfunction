# --- ガジェット配布 ---
give @s minecraft:redstone_torch{is_gadget:1b,gadget_type:1b,display:{Name:'{"text":"マイクロタレット","italic":false,"color":"gold"}',Lore:['{"text":"Cost: 5 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}']}} 1
give @s minecraft:iron_trapdoor{is_gadget:1b,gadget_type:2b,display:{Name:'{"text":"地雷","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 2 SCRAP","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1
give @s minecraft:piston{is_gadget:1b,gadget_type:3b,display:{Name:'{"text":"インパクト・ランチャー","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 3 SCRAP","color":"gray"}','{"text":"CT: 5s","color":"aqua"}']}} 1
give @s minecraft:compass{is_gadget:1b,gadget_type:4b,display:{Name:'{"text":"重力スネア","italic":false,"color":"light_purple"}',Lore:['{"text":"Cost: 6 SCRAP","color":"gray"}','{"text":"CT: 15s","color":"aqua"}']}} 1

# --- 【修正】エンジニアレンチ ---
# Amount:0 ではなく Amount:0.0d と明記し、UUIDの記述を整形しました
give @s minecraft:iron_axe{is_wrench:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Amount:0.0d,Operation:0,Slot:"mainhand",UUID:[I;1234,5678,9012,3456],Name:"no_damage"}],display:{Name:'{"text":"エンジニアレンチ","italic":false,"color":"white"}',Lore:['{"text":"右クリック: 修理 (Cost: 1)","color":"gray"}','{"text":"左クリック: 解体 (Return: 2)","color":"gray"}']}} 1

# 初期スクラップ
scoreboard players set @s scrap 30

# クールダウン初期化
scoreboard players set @s cd_turret 0
scoreboard players set @s cd_mine 0
scoreboard players set @s cd_launcher 0
scoreboard players set @s cd_snare 0