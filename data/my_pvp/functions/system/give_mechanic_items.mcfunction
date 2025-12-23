# --- ガジェット配布 ---
give @s minecraft:redstone_torch{display:{Name:'{"text":"マイクロタレット","italic":false,"color":"gold"}',Lore:['{"text":"Cost: 5 SCRAP","color":"gray"}','{"text":"CoolDown: 5s","color":"aqua"}']}} 1
give @s minecraft:iron_trapdoor{display:{Name:'{"text":"地雷","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 2 SCRAP","color":"gray"}','{"text":"CoolDown: 3s","color":"aqua"}']}} 1
give @s minecraft:piston{display:{Name:'{"text":"インパクト・ランチャー","italic":false,"color":"gray"}',Lore:['{"text":"Cost: 3 SCRAP","color":"gray"}','{"text":"CoolDown: 5s","color":"aqua"}']}} 1
give @s minecraft:compass{display:{Name:'{"text":"重力スネア","italic":false,"color":"light_purple"}',Lore:['{"text":"Cost: 6 SCRAP","color":"gray"}','{"text":"CoolDown: 15s","color":"aqua"}']}} 1

# --- 【修正】エンジニアレンチ ---
# 「鉄の斧を持っていない場合のみ」配布する（これで2本になるのを防ぐ）
execute unless entity @s[nbt={Inventory:[{id:"minecraft:iron_axe"}]}] run give @s minecraft:iron_axe{display:{Name:'{"text":"エンジニアレンチ","italic":false,"color":"white"}',Lore:['{"text":"右クリック: 修理 (Cost: 1)","color":"gray"}','{"text":"スニーク+右クリック: 解体 (Return: 2)","color":"gray"}']}} 1

# --- 初期スクラップ設定 ---
scoreboard players set @s scrap 30