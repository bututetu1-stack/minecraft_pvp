# 1. 自分の位置にマーカー(アンカー)を設置
summon marker ~ ~ ~ {Tags:["freeze_anchor","new_anchor"]}

# 2. アンカーと自分をIDで紐付ける
# (new_anchor の player_id に、自分の player_id をコピーする)
scoreboard players operation @e[type=marker,tag=new_anchor,limit=1] player_id = @s player_id

# 3. タグ処理
tag @e[tag=new_anchor] remove new_anchor
tag @s add has_anchor