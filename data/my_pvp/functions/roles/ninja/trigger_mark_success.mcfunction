# 1. CT設定 (アイテム配布は use_mark で完了しているため不要)
scoreboard players set @s cd_ninja_mark 60

# 2. 身代わり設置ロジックの起動
# 呼び出し元(アイテムがあった場所)にマーカーを立てて実行
tag @e[type=item,nbt={Item:{id:"minecraft:black_dye"}},sort=nearest,limit=1] add temp_mark_origin
execute at @e[tag=temp_mark_origin] run summon marker ~ ~ ~ {Tags:["temp_shadow_loc"]}

execute at @e[tag=temp_shadow_loc,limit=1] run function my_pvp:roles/ninja/place_shadow_logic

# 掃除
kill @e[tag=temp_shadow_loc]
tag @e remove temp_mark_origin