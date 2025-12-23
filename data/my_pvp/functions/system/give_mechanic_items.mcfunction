# エンジニアにガジェット（トリガー用アイテム）を配布
# アイテムに名前や説明（Lore）を付けると、より専用武器感が出ます
give @s minecraft:redstone_torch{display:{Name:'{"text":"マイクロタレット","italic":false,"color":"gold"}',Lore:['{"text":"設置コスト: 5 SCRAP","color":"gray"}']}} 1
give @s minecraft:iron_trapdoor{display:{Name:'{"text":"地雷","italic":false,"color":"gray"}',Lore:['{"text":"設置コスト: 2 SCRAP","color":"gray"}']}} 1
give @s minecraft:piston{display:{Name:'{"text":"インパクト・ランチャー","italic":false,"color":"gray"}',Lore:['{"text":"設置コスト: 3 SCRAP","color":"gray"}']}} 1
give @s minecraft:compass{display:{Name:'{"text":"重力スネア","italic":false,"color":"light_purple"}',Lore:['{"text":"設置コスト: 6 SCRAP","color":"gray"}']}} 1
give @s minecraft:iron_axe{display:{Name:'{"text":"エンジニアレンチ","italic":false,"color":"white"}',Lore:['{"text":"右クリックで修理、スネーク+右クリックで解体","color":"gray"}']}} 1

# 初期スクラップを5個ほど持たせておく
scoreboard players set @s scrap 5