# タイマー処理 (そのまま)
scoreboard players remove @s timer 1
execute if score @s timer matches 1.. run return 0

# --- 攻撃主(飼い主)の特定 ---
# (一応残しておきますが、今回は使いません)
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# --- 爆撃実行 ---
# 一時的な爆心地マーカーを作成し、spreadplayersで散らす
summon area_effect_cloud ~ ~ ~ {Tags:["adm_bomb"],Duration:5}
spreadplayers ~ ~ 0 20 false @e[tag=adm_bomb]

# 演出
execute at @e[tag=adm_bomb] run particle minecraft:explosion_emitter ~ ~ ~ 1 0 0 0 1
execute at @e[tag=adm_bomb] run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 3 1

# --- ダメージ処理 (代理攻撃方式) ---
# 1. 爆心地(adm_bomb)の位置に「航空支援」という名前のプロキシ(防具立て)を召喚
execute at @e[tag=adm_bomb] run summon armor_stand ~ ~ ~ {Tags:["dmg_proxy"],CustomName:'{"text":"航空支援","color":"gold","bold":true}',Invisible:1b,Marker:1b,NoGravity:1b}

# 2. ダメージ実行
# プロキシ(dmg_proxy)の近くにいる全プレイヤー(@a)に対して、プロキシから攻撃させる
# これによりログが「航空支援 に爆破された」になります
execute at @e[tag=adm_bomb] as @a[distance=..5] run damage @s 8 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1,distance=..1]

# 3. 証拠隠滅 (プロキシ削除)
kill @e[tag=dmg_proxy]

# --- 後始末 ---
kill @e[tag=adm_bomb]
tag @a remove attacker_temp

# --- 次のサイクルの準備 ---
scoreboard players remove @s ammo 1
scoreboard players set @s timer 5

# 終了判定
execute unless score @s ammo matches 1.. run kill @e[tag=adm_plane]
execute unless score @s ammo matches 1.. run kill @s