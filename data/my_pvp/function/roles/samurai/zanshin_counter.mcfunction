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

# --- 反撃成功演出 (大幅強化) ---
# パリィ瞬間のフラッシュ
particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force

# 反撃斬撃 (大量パーティクル)
particle minecraft:sweep_attack ~ ~1 ~ 0.7 0.5 0.7 0 12 force
particle minecraft:enchanted_hit ~ ~1 ~ 0.5 0.5 0.5 0.1 20 force
particle minecraft:dust{color:[1.0,1.0,1.0],scale:1.2} ~ ~1 ~ 0.6 0.6 0.6 0 25 force
# 青い反撃のオーラ
particle minecraft:dust{color:[0.3,0.7,1.0],scale:1.5} ~ ~1 ~ 0.8 0.8 0.8 0 20 force
# 衝撃波
particle minecraft:explosion ~ ~1 ~ 0 0 0 0 1 force

# 攻撃者位置にもエフェクト
execute if entity @p[tag=current_attacker] at @p[tag=current_attacker,limit=1] run particle minecraft:dust{color:[1.0,0.0,0.0],scale:1.5} ~ ~1 ~ 0.5 0.5 0.5 0 25 force
execute if entity @p[tag=current_attacker] at @p[tag=current_attacker,limit=1] run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force

# 効果音層 (盾砕け + 三叉戟ヒット + 金属斬撃 + 雷撃感)
playsound minecraft:item.shield.break master @a ~ ~ ~ 1.5 1.5
playsound minecraft:item.trident.hit master @a ~ ~ ~ 1.5 1.4
playsound minecraft:entity.player.attack.crit master @a ~ ~ ~ 1.5 1.5
playsound minecraft:item.trident.thunder master @a ~ ~ ~ 1 2

# チャット通知
tellraw @s [{"text":"[残心] ","color":"dark_blue","bold":true},{"text":"反撃成功！","color":"yellow"}]
execute if entity @p[tag=current_attacker] run tellraw @p[tag=current_attacker,limit=1] [{"text":"[残心] ","color":"dark_blue","bold":true},{"text":"反撃を受けた！","color":"red"}]

# 構え終了
function my_pvp:roles/samurai/end_zanshin

# 後処理
tag @a remove current_attacker
