# --- 1. 攻撃主(飼い主)の特定 ---
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# --- 2. 演出 ---
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 5 0.5
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 1 1 force
particle minecraft:flash ~ ~ ~ 0 0 0 0 1 force
particle minecraft:cloud ~ ~1 ~ 6 2 6 0.1 200 force
particle minecraft:lava ~ ~1 ~ 5 1 5 0.1 50 force
particle minecraft:flame ~ ~1 ~ 6 2 6 0.2 100 force
particle minecraft:campfire_signal_smoke ~ ~ ~ 7 0 7 0.1 50 force

# --- 3. ダメージ処理 (代理攻撃方式・修正版2) ---
# 「防具立て(armor_stand)」をプロキシとして召喚
# ※Marker:1b にすることで当たり判定を無くし、処理を軽くしています
summon armor_stand ~ ~ ~ {Tags:["dmg_proxy"],CustomName:'{"text":"砲撃支援","color":"gold","bold":true}',Invisible:1b,Marker:1b,NoGravity:1b}

# 【重要】ダメージの種類を "player_explosion" に指定して実行
# これによりログが「爆発に巻き込まれた」ではなく「砲撃支援 に爆破された」になります
execute as @a[distance=..10] run damage @s 20 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,distance=..10]

# 証拠隠滅
kill @e[tag=dmg_proxy]

# --- 4. 後始末 ---
tag @a remove attacker_temp
kill @s