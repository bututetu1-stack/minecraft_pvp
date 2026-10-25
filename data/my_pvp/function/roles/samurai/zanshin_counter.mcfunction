# 残心成功: 反撃斬撃
# 自分のIDをTEMPに保存
scoreboard players operation #TEMP player_id = @s player_id

# 攻撃者を特定 (直前に攻撃してきたプレイヤー / 10m以内)
# ※ 以前の damage_dealt と last_damage_dealt の比較は、last_damage_dealt を更新する役職が限られるため
#    10m以内の全員が攻撃者扱いになっていた
tag @a remove current_attacker
execute on attacker if entity @s[type=player,distance=..10,gamemode=!spectator] unless score @s player_id = #TEMP player_id run tag @s add current_attacker

# 反撃ダメージ (10ダメージ)
execute if entity @p[tag=current_attacker] run damage @p[tag=current_attacker,limit=1] 10 minecraft:magic by @s

# 自身に効果 (短時間 強化)
effect give @s minecraft:strength 4 0 true
effect give @s minecraft:resistance 2 1 true

# 演出
particle minecraft:sweep_attack ~ ~1 ~ 0.5 0.3 0.5 0 5
playsound minecraft:item.trident.hit master @a ~ ~ ~ 1.2 1.2
playsound minecraft:item.shield.break master @a ~ ~ ~ 1 1.5

# 通知
tellraw @s [{"text":"[残心] ","color":"aqua","bold":true},{"text":"反撃成功！","color":"yellow"}]
execute if entity @p[tag=current_attacker] run tellraw @p[tag=current_attacker,limit=1] [{"text":"[残心] ","color":"aqua","bold":true},{"text":"反撃を受けた！","color":"red"}]

# 構え終了
function my_pvp:roles/samurai/end_zanshin

# 後処理
tag @a remove current_attacker
