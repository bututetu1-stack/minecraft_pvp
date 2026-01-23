# --- ランダムリスポーン処理 ---

# 1. アリーナ中心マーカー(@e[tag=arena_center])を基準に、半径150ブロック以内に飛ばす
execute at @e[tag=arena_center,limit=1] run spreadplayers ~ ~ 10 150 false @s

# 2. 死亡スコアをリセット (これをしないと無限にループします)
scoreboard players set @s deaths 0

# 3. メッセージと演出
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"戦場へ復帰しました！","color":"yellow"}]
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 1

# (オプション) もしリスポーン時に特定のアイテムを再配布したい場合はここに記述
# 例: function my_pvp:roles/common/give_kit