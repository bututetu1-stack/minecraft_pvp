# CTチェック
execute if score @s cd_adm_torpedo matches 1.. run return 0
scoreboard players set @s cd_adm_torpedo 200
playsound minecraft:item.trident.riptide_1 master @a ~ ~ ~ 1 0.5
tellraw @s {"text":"⚡ 魚雷発射！","color":"aqua"}

# --- ガチャ判定 (0,1,2) ---
# 修正: プレイヤーのUUIDではなく、一時的なマーカーのUUIDを使って完全ランダムにする
summon area_effect_cloud ~ ~ ~ {Tags:["rng_temp"]}
execute store result score @s temp run data get entity @e[tag=rng_temp,limit=1] UUID[0]
kill @e[tag=rng_temp]

scoreboard players set #CONST_3 temp 3
scoreboard players operation @s temp %= #CONST_3 temp
execute if score @s temp matches ..-1 run scoreboard players add @s temp 3

# --- セリフ表示 ---
# 島風
execute if score @s temp matches 0 run tellraw @s [{"text":"[島風] ","color":"aqua","bold":true},{"text":"五連装酸素魚雷！いっちゃってぇー！","color":"white","bold":false}]
# 阿武隈
execute if score @s temp matches 1 run tellraw @s [{"text":"[阿武隈] ","color":"gold","bold":true},{"text":"阿武隈、ご期待に応えます！","color":"white","bold":false}]
# 北上
execute if score @s temp matches 2 run tellraw @s [{"text":"[北上] ","color":"green","bold":true},{"text":"40門の酸素魚雷は伊達じゃないからねっと！","color":"white","bold":false}]

# --- 魚雷生成 (統合ファイル呼び出し) ---
function my_pvp:roles/admiral/summon_torpedo_patterns

# --- 共通仕上げ ---
scoreboard players operation @e[tag=new_torp] player_id = @s player_id
tag @e[tag=new_torp] remove new_torp