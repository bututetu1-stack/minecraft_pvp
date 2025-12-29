# 攻撃した相手がターゲットかどうかを確認

# 1. 攻撃対象候補の取得（重要：自分を除外するために distance=0.1..4 に変更）
# distance=..4 だと自分(distance=0)が最優先で選ばれてしまい、敵への判定が行われません
tag @a remove attacked_victim
execute at @s as @a[distance=0.1..4,sort=nearest,limit=1,gamemode=!spectator] run tag @s add attacked_victim

# 2. ID照合
# ストーカーの持つターゲットIDを一時スコアにコピー
scoreboard players operation #TEMP player_id = @s target_id

# 被害者のIDと比較し、一致したら is_my_target タグを付与
execute as @a[tag=attacked_victim] if score @s player_id = #TEMP player_id run tag @s add is_my_target

# 3. ターゲットへの追加ダメージ (4ダメージ = ハート2個分)
# damageコマンド：ターゲットに対して、ストーカー(@s)を攻撃元としてダメージを与える
execute as @a[tag=is_my_target] run damage @s 4 minecraft:player_attack by @p[tag=stalker,limit=1,distance=..6]

# 演出 (クリティカル)
execute if entity @a[tag=is_my_target] run playsound minecraft:entity.player.attack.crit master @s ~ ~ ~ 1 0.8
execute if entity @a[tag=is_my_target] at @a[tag=is_my_target] run particle minecraft:crit ~ ~1.5 ~ 0.5 0.5 0.5 0.1 20

# 4. ターゲット以外への演出 (失敗音)
# 攻撃判定はあったが、ターゲットではなかった場合
execute if entity @a[tag=attacked_victim,tag=!is_my_target] run playsound minecraft:block.chain.place master @s ~ ~ ~ 1 2

# 5. タグの掃除
tag @a remove attacked_victim
tag @a remove is_my_target