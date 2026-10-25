# 衝撃波 発動 (@s = magician, at @s)

# CT中チェック
execute if score @s cd_mag_shockwave matches 1.. run tellraw @s [{"text":"[Shockwave] ","color":"aqua"},{"text":"クールダウン中...","color":"gray"}]
execute if score @s cd_mag_shockwave matches 1.. run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
execute if score @s cd_mag_shockwave matches 1.. run return 0

# MPチェック
execute if score @s mana matches ..14 run tellraw @s [{"text":"[Shockwave] ","color":"aqua"},{"text":"マナが足りません！ (15必要)","color":"red"}]
execute if score @s mana matches ..14 run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
execute if score @s mana matches ..14 run return 0

# === 発動: コスト消費 + CT設定 ===
execute unless entity @s[tag=rush_mode] run scoreboard players remove @s mana 15
execute unless entity @s[tag=rush_mode] run scoreboard players set @s cd_mag_shockwave 100

# 自分のIDを TEMP に保存 (自己ダメージ除外用)
scoreboard players operation #TEMP player_id = @s player_id

# === 演出 ===
playsound minecraft:entity.warden.sonic_boom master @a ~ ~ ~ 1 1.5
playsound minecraft:entity.lightning_bolt.thunder master @a[distance=..30] ~ ~ ~ 0.7 1.8
playsound minecraft:entity.player.attack.sweep master @a[distance=..15] ~ ~ ~ 1 0.8
particle minecraft:explosion ~ ~1 ~ 0 0 0 0 1 force
particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
particle minecraft:sonic_boom ~ ~1 ~ 0 0 0 0 1 force
# リング (4m 円周, 8方向, ワールド軸基準=tilde, omnidirectional)
particle minecraft:dust{color:[0.7,0.9,1.0],scale:1.5} ~ ~1 ~4 0 0 0 0 1 force
particle minecraft:dust{color:[0.7,0.9,1.0],scale:1.5} ~ ~1 ~-4 0 0 0 0 1 force
particle minecraft:dust{color:[0.7,0.9,1.0],scale:1.5} ~4 ~1 ~ 0 0 0 0 1 force
particle minecraft:dust{color:[0.7,0.9,1.0],scale:1.5} ~-4 ~1 ~ 0 0 0 0 1 force
particle minecraft:dust{color:[0.7,0.9,1.0],scale:1.5} ~2.8 ~1 ~2.8 0 0 0 0 1 force
particle minecraft:dust{color:[0.7,0.9,1.0],scale:1.5} ~-2.8 ~1 ~2.8 0 0 0 0 1 force
particle minecraft:dust{color:[0.7,0.9,1.0],scale:1.5} ~2.8 ~1 ~-2.8 0 0 0 0 1 force
particle minecraft:dust{color:[0.7,0.9,1.0],scale:1.5} ~-2.8 ~1 ~-2.8 0 0 0 0 1 force
particle minecraft:sweep_attack ~ ~1 ~2 0 0 0 0 1 force
particle minecraft:sweep_attack ~ ~1 ~-2 0 0 0 0 1 force
particle minecraft:sweep_attack ~2 ~1 ~ 0 0 0 0 1 force
particle minecraft:sweep_attack ~-2 ~1 ~ 0 0 0 0 1 force

# === 攻撃判定 ===
# 半径4m の他プレイヤーに damage + slowness II
# AECで攻撃主表記
summon area_effect_cloud ~ ~ ~ {Tags:["shock_proxy"],Duration:5,CustomName:'{"text":"魔術師の衝撃波","color":"aqua","bold":true}'}
execute as @a[distance=..4,gamemode=!spectator] unless score @s player_id = #TEMP player_id run damage @s 8 minecraft:player_explosion by @e[tag=shock_proxy,limit=1,sort=nearest] from @e[tag=shock_proxy,limit=1,sort=nearest]
execute as @a[distance=..4,gamemode=!spectator] unless score @s player_id = #TEMP player_id run effect give @s minecraft:slowness 2 1 true
# キル判定 (deaths増加検知)
tellraw @s [{"text":"[Shockwave] ","color":"aqua","bold":true},{"text":"衝撃波を放った！","color":"yellow"}]

# AEC 後始末
kill @e[tag=shock_proxy,distance=..2]
