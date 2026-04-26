# 狼自爆処理 (@s = wolf, at @s)
# 呼び出し元で #TEMP player_id = beastmaster の player_id

# 演出
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1.2 1.2
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1 force
particle minecraft:dust{color:[1.0,0.3,0.3],scale:1.3} ~ ~1 ~ 0.5 0.5 0.5 0 25 force
particle minecraft:large_smoke ~ ~ ~ 0.5 0.3 0.5 0.05 15 force

# 半径3内の敵 (自分=オーナー以外) にダメージ
execute at @s as @a[gamemode=!spectator,distance=..3] unless score @s player_id = #TEMP player_id run damage @s 5 minecraft:player_explosion by @p[tag=beastmaster,limit=1]
# 軽いノックバック (effect levitation 1tick)
execute at @s as @a[gamemode=!spectator,distance=..3] unless score @s player_id = #TEMP player_id run effect give @s minecraft:levitation 1 1 true

# 自分(狼) を消滅
kill @s
