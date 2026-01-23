# 彫刻召喚処理
# スロット循環方式 (1-20) で上書き
# @a[tag=current_caster] が召喚者

# --- 1. スロットサイクル処理 ---
# サイクルが 1..20 の範囲かチェック (安全装置)
execute as @a[tag=current_caster] unless score @s sculpture_cycle matches 1..20 run scoreboard players set @s sculpture_cycle 1

# --- 2. 既存スロットの削除 ---
# 現在のサイクル値と同じスロットを持つ彫刻があれば削除 (上書き)
execute as @a[tag=current_caster] run scoreboard players operation #TEMP_SLOT temp = @s sculpture_cycle
execute as @a[tag=current_caster] run scoreboard players operation #TEMP_OWNER temp = @s player_id

# 削除対象: (自分のID && スロット一致)
# 実数カウント方式にするため、removeは不要。killのみ行う。
execute as @e[tag=sculpture] if score @s player_id = #TEMP_OWNER temp if score @s sculpture_slot = #TEMP_SLOT temp run kill @s
execute as @e[tag=sculpture_hitbox] if score @s player_id = #TEMP_OWNER temp if score @s sculpture_slot = #TEMP_SLOT temp run kill @s

# --- 3. ランダムでテーマを決定 (UUID方式) ---
# 乱数生成用の一時マーカーを召喚
summon marker ~ ~ ~ {Tags:["random_seed"]}

# マーカーのUUIDを利用して乱数を得る (UUID[0]を取得)
execute store result score #SCULPT_THEME temp run data get entity @e[tag=random_seed,limit=1] UUID[0]

# 定数をセット
scoreboard players set #CONST_8 temp 8

# 8で割った余りを取得
scoreboard players operation #SCULPT_THEME temp %= #CONST_8 temp

# 負の数の場合、正にする (-7..-1 -> 1..7)
execute if score #SCULPT_THEME temp matches ..-1 run scoreboard players add #SCULPT_THEME temp 8

# マーカー削除
kill @e[tag=random_seed]


# --- 4. テーマ別に彫刻を召喚 ---
# テーマ0: 呪いの彫刻 (吐き気)
execute if score #SCULPT_THEME temp matches 0 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_nausea","new_sculpture"],CustomName:'{"text":"呪いの彫刻","color":"dark_purple","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",Count:1b}]}
execute if score #SCULPT_THEME temp matches 0 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"呪いの彫刻","color":"dark_purple"},{"text":" (見ると吐き気)","color":"white"}]

# テーマ1: 毒の彫刻 (毒)
execute if score #SCULPT_THEME temp matches 1 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_poison","new_sculpture"],CustomName:'{"text":"毒の彫刻","color":"dark_green","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{},{},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:5635925}}},{id:"minecraft:wither_skeleton_skull",Count:1b}],HandItems:[{id:"minecraft:poisonous_potato",Count:1b},{}]}
execute if score #SCULPT_THEME temp matches 1 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"毒の彫刻","color":"dark_green"},{"text":" (見ると毒)","color":"white"}]

# テーマ2: 鈍足の彫刻 (移動速度低下)
execute if score #SCULPT_THEME temp matches 2 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_slow","new_sculpture"],CustomName:'{"text":"鈍足の彫刻","color":"gray","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:5000268}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:5000268}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:5000268}}},{}],HandItems:[{id:"minecraft:cobweb",Count:1b},{}]}
execute if score #SCULPT_THEME temp matches 2 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"鈍足の彫刻","color":"gray"},{"text":" (見ると移動速度低下)","color":"white"}]

# テーマ3: 盲目の彫刻 (盲目)
execute if score #SCULPT_THEME temp matches 3 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_blind","new_sculpture"],CustomName:'{"text":"盲目の彫刻","color":"black","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{},{},{},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:"MHF_Herobrine"}}],HandItems:[{id:"minecraft:ender_eye",Count:1b},{}]}
execute if score #SCULPT_THEME temp matches 3 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"盲目の彫刻","color":"dark_gray"},{"text":" (見ると盲目)","color":"white"}]

# テーマ4: 発光の彫刻 (発光)
execute if score #SCULPT_THEME temp matches 4 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_glow","new_sculpture"],CustomName:'{"text":"発光の彫刻","color":"yellow","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{id:"minecraft:golden_boots",Count:1b},{id:"minecraft:golden_leggings",Count:1b},{id:"minecraft:golden_chestplate",Count:1b},{id:"minecraft:golden_helmet",Count:1b}],HandItems:[{id:"minecraft:glowstone",Count:1b},{}]}
execute if score #SCULPT_THEME temp matches 4 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"発光の彫刻","color":"yellow"},{"text":" (見ると発光)","color":"white"}]

# テーマ5: 暗闘の彫刻 (暗闇)
execute if score #SCULPT_THEME temp matches 5 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_darkness","new_sculpture"],CustomName:'{"text":"暗闇の彫刻","color":"dark_gray","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{id:"minecraft:netherite_boots",Count:1b},{id:"minecraft:netherite_leggings",Count:1b},{id:"minecraft:netherite_chestplate",Count:1b},{}],HandItems:[{id:"minecraft:sculk",Count:1b},{}]}
execute if score #SCULPT_THEME temp matches 5 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"暗闘の彫刻","color":"dark_gray"},{"text":" (見ると暗闇)","color":"white"}]

# テーマ6: 鈍重の彫刻 (攻撃速度低下)
execute if score #SCULPT_THEME temp matches 6 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_fatigue","new_sculpture"],CustomName:'{"text":"鈍重の彫刻","color":"blue","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{},{},{id:"minecraft:iron_chestplate",Count:1b},{}],HandItems:[{id:"minecraft:anvil",Count:1b},{}]}
execute if score #SCULPT_THEME temp matches 6 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"鈍重の彫刻","color":"blue"},{"text":" (見ると攻撃速度低下)","color":"white"}]

# テーマ7: 回復の彫刻 (破壊で回復)
execute if score #SCULPT_THEME temp matches 7 run summon armor_stand ~ ~ ~ {Tags:["sculpture","sculpture_heal","new_sculpture"],CustomName:'{"text":"回復の彫刻","color":"green","italic":false}',ShowArms:1b,NoBasePlate:1b,Invulnerable:0b,ArmorItems:[{},{},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:5635925}}},{id:"minecraft:player_head",Count:1b}],HandItems:[{id:"minecraft:golden_apple",Count:1b},{}]}
execute if score #SCULPT_THEME temp matches 7 run tellraw @a[tag=current_caster] [{"text":"[彫刻] ","color":"gray"},{"text":"回復の彫刻","color":"green"},{"text":" (破壊でHP回復)","color":"white"}]

# --- 5. スロットIDとオーナーIDを付与 ---
execute as @a[tag=current_caster] run scoreboard players operation @e[tag=new_sculpture,limit=1] player_id = @s player_id
execute as @a[tag=current_caster] run scoreboard players operation @e[tag=new_sculpture,limit=1] sculpture_slot = @s sculpture_cycle

# hitbox生成 & ID付与
execute as @a[tag=current_caster] at @s run summon interaction ~ ~ ~ {Tags:["sculpture_hitbox","new_hitbox"],width:0.8f,height:2.0f,response:1b}
execute as @a[tag=current_caster] run scoreboard players operation @e[tag=new_hitbox,limit=1] player_id = @s player_id
execute as @a[tag=current_caster] run scoreboard players operation @e[tag=new_hitbox,limit=1] sculpture_slot = @e[tag=new_sculpture,limit=1] sculpture_slot

# HP初期値を3に設定
scoreboard players set @e[tag=new_hitbox] sculpture_hp 3

# プレイヤーの向きを同期
execute as @e[tag=new_sculpture] run data modify entity @s Rotation set from entity @p[tag=current_caster] Rotation

# Hitboxに効果タグを同期 (レイキャスト判定用)
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_nausea] run tag @s add sculpture_nausea
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_poison] run tag @s add sculpture_poison
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_slow] run tag @s add sculpture_slow
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_blind] run tag @s add sculpture_blind
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_glow] run tag @s add sculpture_glow
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_darkness] run tag @s add sculpture_darkness
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_fatigue] run tag @s add sculpture_fatigue
execute as @e[tag=new_hitbox] if entity @e[tag=new_sculpture,tag=sculpture_heal] run tag @s add sculpture_heal

tag @e[tag=new_sculpture] remove new_sculpture
tag @e[tag=new_hitbox] remove new_hitbox

# --- 6. カウント増加 & 演出 ---
# 実数再計算: 自分のIDを持つ彫刻(@e[tag=sculpture])の数を数える
# まずリセット
scoreboard players set @a[tag=current_caster] sculpture_count 0
# TEMP_OWNERには既にplayer_idが入っている
execute as @e[tag=sculpture] if score @s player_id = #TEMP_OWNER temp run scoreboard players add @a[tag=current_caster] sculpture_count 1

# CTをセット (100tick = 5秒)
scoreboard players set @a[tag=current_caster] cd_sculptor_create 100

# 音 (任命時と同じ、金床使用音)
playsound minecraft:block.anvil.use master @a ~ ~ ~ 1 0.8
particle minecraft:cloud ~ ~1 ~ 0.3 0.5 0.3 0.02 10

# 通知: 設置数のみ表示
execute as @a[tag=current_caster] run tellraw @s [{"text":"[System] ","color":"gray"},{"text":"彫刻設置数: ","color":"white"},{"score":{"name":"@s","objective":"sculpture_count"},"color":"blue"},{"text":"/20","color":"gray"}]

# カウント補正 (実数カウントなので基本不要だが念のため)
execute as @a[tag=current_caster] if score @s sculpture_count matches 21.. run scoreboard players set @s sculpture_count 20

# --- 7. サイクルを進める ---
scoreboard players add @a[tag=current_caster] sculpture_cycle 1
execute as @a[tag=current_caster] if score @s sculpture_cycle matches 21.. run scoreboard players set @s sculpture_cycle 1
