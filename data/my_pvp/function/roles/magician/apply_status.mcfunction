# 魔術師のステータス復旧 (HP 40)
# 最大体力を40に設定
attribute @s minecraft:generic.max_health base set 40

# リスポーン直後の全回復
effect give @s minecraft:instant_health 1 100 true
effect give @s minecraft:saturation 1 255 true
# リスポーン時にマナを回復（初期値: 50）
scoreboard players set @s mana 50
