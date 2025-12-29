# 実行者: 矢 (@s)
# 前提: arrow_tick.mcfunction でヒットした敵にタグ 'arrow_hit_victim' が付いていること

# 1. 矢の所有者（スカウト）を特定する
tag @a remove current_owner
scoreboard players operation #TEMP player_id = @s player_id
execute as @a[tag=scout] if score @s player_id = #TEMP player_id run tag @s add current_owner

# 2. 引き寄せ処理
# 被害者を強制的に所有者の方へ向かせ、前方（所有者側）へ3マス、上へ0.5マス飛ばす
execute as @a[tag=arrow_hit_victim] at @s facing entity @p[tag=current_owner] feet run tp @s ^ ^0.5 ^3.0

# 3. メッセージ通知 (tellrawを使用)
# 被害者への通知
tellraw @a[tag=arrow_hit_victim] {"text":"[警告] スカウトの矢に捕縛され、引き寄せられました！","color":"red","bold":true}
# スカウトへの通知
tellraw @p[tag=current_owner] {"text":"[Scout] 敵を捕縛し、引き寄せました！","color":"aqua"}

# 4. 効果音と演出
execute at @a[tag=arrow_hit_victim] run playsound minecraft:entity.fishing_bobber.retrieve master @a ~ ~ ~ 1 1
execute at @a[tag=arrow_hit_victim] run particle minecraft:crit ~ ~1 ~ 0.5 0.5 0.5 0.1 30

# 5. ヒットしたので矢を削除
kill @s