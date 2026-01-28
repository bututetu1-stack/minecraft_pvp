# フラグ解除
tag @s remove is_grappling

# アンカー削除
scoreboard players operation #TEMP player_id = @s player_id
execute as @e[tag=wire_anchor] if score @s player_id = #TEMP player_id run kill @s

# --- 【修正】到着時の処理 ---
# スニーク(キャンセル操作)をしていない場合のみ、浮遊を付与
# ※落下ダメージ無効のため、slow_falling(着地保護)は削除しました
execute unless predicate my_pvp:is_sneaking run effect give @s minecraft:levitation 1 5 true

# --- 音の競合対策 ---
# 1. ティックカウンターをリセット (pull_logicでの上書き再生防止)
scoreboard players set @s sound_ticker 0

# 2. 風切り音を停止 (終了音をクリアに鳴らすため先に止める)
stopsound @s master minecraft:item.elytra.flying

# 3. 終了音 (着地/到着)
playsound minecraft:entity.player.attack.sweep master @s ~ ~ ~ 1 1