# 【追加】凍結中は処理を停止
execute if entity @s[tag=is_frozen] run return 0

# --- 1. 旋回処理 ---
tp @s ~ ~ ~ ~4 ~

# ファントム公転
# ファントム公転 (ID一致のみ)
scoreboard players operation #MY_ID temp = @s player_id
execute at @s as @e[tag=plane_1] if score @s player_id = #MY_ID temp run tp @s ^ ^15 ^10 facing ^-10 ^15 ^10
execute at @s as @e[tag=plane_2] if score @s player_id = #MY_ID temp run tp @s ^10 ^18 ^-5 facing ^15 ^18 ^5
execute at @s as @e[tag=plane_3] if score @s player_id = #MY_ID temp run tp @s ^-10 ^18 ^-5 facing ^-5 ^18 ^-15

# --- 2. 共通処理 & 範囲警告 ---
particle minecraft:campfire_signal_smoke ~ ~0.5 ~ 0 0.5 0 0.1 5 force

# 警告リング (変更なし)
# A. 加賀
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^ ^ ^30 0 0 0 0 1 force
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^ ^ ^-30 0 0 0 0 1 force
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^30 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^-30 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^ ^ ^30 0 0 0 0 1 force
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^ ^ ^-30 0 0 0 0 1 force
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^30 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_kaga] positioned ~ ~1 ~ run particle dust{color:[0.0,0.0,1.0],scale:2.0} ^-30 ^ ^ 0 0 0 0 1 force
# B. 瑞鶴
execute if entity @s[tag=type_zuikaku] positioned ~ ~1 ~ run particle dust{color:[0.0,1.0,0.0],scale:2.0} ^ ^ ^25 0 0 0 0 1 force
execute if entity @s[tag=type_zuikaku] positioned ~ ~1 ~ run particle dust{color:[0.0,1.0,0.0],scale:2.0} ^ ^ ^-25 0 0 0 0 1 force
execute if entity @s[tag=type_zuikaku] positioned ~ ~1 ~ run particle dust{color:[0.0,1.0,0.0],scale:2.0} ^25 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_zuikaku] positioned ~ ~1 ~ run particle dust{color:[0.0,1.0,0.0],scale:2.0} ^-25 ^ ^ 0 0 0 0 1 force
# C. 瑞鳳
execute if entity @s[tag=type_zuiho] positioned ~ ~1 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^ ^ ^20 0 0 0 0 1 force
execute if entity @s[tag=type_zuiho] positioned ~ ~1 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^ ^ ^-20 0 0 0 0 1 force
execute if entity @s[tag=type_zuiho] positioned ~ ~1 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^20 ^ ^ 0 0 0 0 1 force
execute if entity @s[tag=type_zuiho] positioned ~ ~1 ~ run particle dust{color:[1.0,0.0,0.0],scale:2.0} ^-20 ^ ^ 0 0 0 0 1 force

# タイマー処理
scoreboard players remove @s timer 1
execute if score @s timer matches 1.. run return 0

# 攻撃主特定
scoreboard players operation #OWNER_ID temp = @s player_id

# --- 3. 爆弾投下 (2個同時) ---
# 3-1. 爆弾召喚 (Duration 100tick = 5秒)
# 【変更】2行書いて2つ同時に召喚する
summon area_effect_cloud ~ ~ ~ {Tags:["adm_bomb","new_bomb"],Duration:100}
summon area_effect_cloud ~ ~ ~ {Tags:["adm_bomb","new_bomb"],Duration:100}

# 3-2. ID継承 (new_bombタグがついた全エンティティに適用されるので変更なし)
execute as @e[tag=new_bomb] run scoreboard players operation @s player_id = #OWNER_ID temp

# 3-3. ガチャ (個別にランダム判定されるので変更なし)
scoreboard players set #CONST_10 temp 10
execute as @e[tag=new_bomb] store result score @s temp run data get entity @s UUID[0]
execute as @e[tag=new_bomb] run scoreboard players operation @s temp %= #CONST_10 temp
execute as @e[tag=new_bomb] if score @s temp matches ..-1 run scoreboard players add @s temp 10
execute as @e[tag=new_bomb] run scoreboard players add @s temp 1

# 種類決定
execute as @e[tag=new_bomb] if score @s temp matches 1..6 run tag @s add type_suisei
execute as @e[tag=new_bomb] if score @s temp matches 1..6 run data modify entity @s CustomName set value '{"text":"彗星一二型甲","color":"red","bold":true}'

execute as @e[tag=new_bomb] if score @s temp matches 7..9 run tag @s add type_reppu
execute as @e[tag=new_bomb] if score @s temp matches 7..9 run data modify entity @s CustomName set value '{"text":"烈風改","color":"green","bold":true}'

execute as @e[tag=new_bomb] if score @s temp matches 10 run tag @s add type_ryusei
execute as @e[tag=new_bomb] if score @s temp matches 10 run data modify entity @s CustomName set value '{"text":"流星改","color":"blue","bold":true}'

# 3-4. 拡散 (2つとも範囲内にばら撒かれる)
execute if entity @s[tag=type_kaga] run spreadplayers ~ ~ 0 30 false @e[tag=new_bomb]
execute if entity @s[tag=type_zuikaku] run spreadplayers ~ ~ 0 25 false @e[tag=new_bomb]
execute if entity @s[tag=type_zuiho] run spreadplayers ~ ~ 0 20 false @e[tag=new_bomb]

# 3-5. 起爆タイマー設定
execute as @e[tag=new_bomb] run scoreboard players set @s temp 40
execute as @e[tag=new_bomb] run tag @s add bomb_falling

tag @e[tag=new_bomb] remove new_bomb

# --- 4. サイクル更新 ---
# 【変更】弾数を 2 減らす
scoreboard players remove @s ammo 2
scoreboard players set @s timer 5

# 終了判定
# 1. ID一致ファントム処理
execute unless score @s ammo matches 1.. as @e[tag=adm_plane] if score @s player_id = #MY_ID temp run data modify entity @s Invulnerable set value 0b
execute unless score @s ammo matches 1.. as @e[tag=adm_plane] if score @s player_id = #MY_ID temp run tp @s ~ -100 ~
execute unless score @s ammo matches 1.. as @e[tag=adm_plane] if score @s player_id = #MY_ID temp run kill @s

# 2. 残留ファントム処理 (範囲)
execute unless score @s ammo matches 1.. as @e[tag=adm_plane,distance=..300] run data modify entity @s Invulnerable set value 0b
execute unless score @s ammo matches 1.. as @e[tag=adm_plane,distance=..300] run tp @s ~ -100 ~
execute unless score @s ammo matches 1.. run kill @e[tag=adm_plane,distance=..300]

# 3. 自身(Center)の削除
execute unless score @s ammo matches 1.. run kill @s