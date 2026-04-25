# 居合発動
# CTチェック
execute if score @s cd_sam_iai matches 1.. run return 0

# CT設定 (10秒)
scoreboard players set @s cd_sam_iai 200

# 突進状態タグ (8tick = 0.4秒)
tag @s add sam_iai_dashing
scoreboard players set @s sam_iai_active 8

# 短時間の保護 (居合中はダメージ軽減)
effect give @s minecraft:resistance 1 2 true
effect give @s minecraft:speed 2 4 true

# --- 演出 (大幅強化) ---
# パーティクル: 抜刀の閃光
particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force
# 衝撃波 (足元の鈍色ダスト)
particle minecraft:dust{color:[0.6,0.7,0.85],scale:1.5} ~ ~0.2 ~ 1.5 0.1 1.5 0 30 force
# 抜刀斬撃
particle minecraft:sweep_attack ~ ~1 ~ 0.3 0.3 0.3 0 8 force
# 視線方向への斬撃軌跡
execute at @s anchored eyes positioned ^ ^ ^1 run particle minecraft:dust{color:[1.0,1.0,1.0],scale:0.8} ~ ~ ~ 0.2 0.2 0.2 0.2 25 force
execute at @s anchored eyes positioned ^ ^ ^2 run particle minecraft:enchanted_hit ~ ~ ~ 0.2 0.2 0.2 0 10 force

# 効果音層 (抜刀音 + 風切り音 + 鋭い金属音)
playsound minecraft:item.trident.throw master @a ~ ~ ~ 1.5 1.8
playsound minecraft:entity.player.attack.sweep master @a ~ ~ ~ 1.8 2.0
playsound minecraft:item.armor.equip_iron master @a ~ ~ ~ 1 0.5
playsound minecraft:entity.arrow.shoot master @a ~ ~ ~ 1.2 1.3

# チャット通知
tellraw @s [{"text":"[居合] ","color":"dark_blue","bold":true},{"text":"抜刀！","color":"yellow"}]
