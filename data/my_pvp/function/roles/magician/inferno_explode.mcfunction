# 業火爆裂 着弾処理 (at = 着弾点, @s = inferno marker)
# 攻撃主ID は #INF_OWNER temp に既に保存済み

# === 演出: 中心 ===
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 3 1.0
playsound minecraft:item.firecharge.use master @a[distance=..30] ~ ~ ~ 2 0.8
playsound minecraft:entity.lightning_bolt.impact master @a[distance=..40] ~ ~ ~ 1 1.2
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 1 1 force
particle minecraft:flash ~ ~ ~ 0 0 0 0 2 force

# === 演出: 半径5m の炎リング ===
particle minecraft:lava ^ ~0.5 ^5 0.3 0.5 0.3 0 8 force
particle minecraft:lava ^ ~0.5 ^-5 0.3 0.5 0.3 0 8 force
particle minecraft:lava ^5 ~0.5 ^ 0.3 0.5 0.3 0 8 force
particle minecraft:lava ^-5 ~0.5 ^ 0.3 0.5 0.3 0 8 force
particle minecraft:lava ^3.5 ~0.5 ^3.5 0.3 0.5 0.3 0 8 force
particle minecraft:lava ^-3.5 ~0.5 ^3.5 0.3 0.5 0.3 0 8 force
particle minecraft:lava ^3.5 ~0.5 ^-3.5 0.3 0.5 0.3 0 8 force
particle minecraft:lava ^-3.5 ~0.5 ^-3.5 0.3 0.5 0.3 0 8 force

# === 演出: 火柱 (中心から空に20m) ===
particle minecraft:flame ~ ~5 ~ 1 4 1 0.1 80 force
particle minecraft:dust{color:[1.0,0.4,0.0],scale:2.5} ~ ~6 ~ 1.5 4 1.5 0 50 force

# === 演出: 衝撃波リング (赤dust) ===
particle minecraft:dust{color:[1.0,0.5,0.0],scale:3.0} ~ ~0.3 ~ 5 0.2 5 0 60 force

# === ダメージ処理 ===
# 代理AECを召喚 (death メッセージ用)
summon area_effect_cloud ~ ~ ~ {Tags:["inferno_proxy"],Duration:5,CustomName:'{"text":"魔術師の業火","color":"red","bold":true}'}

# 半径5m の他プレイヤーに damage 12 + 3秒燃焼
execute as @a[distance=..5,gamemode=!spectator] unless score @s player_id = #INF_OWNER temp run damage @s 12 minecraft:player_explosion by @e[tag=inferno_proxy,limit=1,sort=nearest] from @e[tag=inferno_proxy,limit=1,sort=nearest]
execute as @a[distance=..5,gamemode=!spectator] unless score @s player_id = #INF_OWNER temp run data merge entity @s {fire_ticks: 60s}

# AEC 後始末
kill @e[tag=inferno_proxy,distance=..2]
