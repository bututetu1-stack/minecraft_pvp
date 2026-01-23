# バースト処理 (>21)
# @s = player

tellraw @s {"text":"[BJ] BURST! (21を超えました)","color":"dark_red","bold":true}

# 効果: 20ダメージ (魔法ダメージ)
damage @s 20 minecraft:magic

# デバフ (前回同様)
effect give @s minecraft:slowness 10 2 true
effect give @s minecraft:weakness 10 1 true

# 終了
scoreboard players set @s bj_state 0
