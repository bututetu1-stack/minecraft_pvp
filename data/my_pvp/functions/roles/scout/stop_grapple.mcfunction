# フラグ解除
tag @s remove is_grappling

# アンカー削除
scoreboard players operation #TEMP player_id = @s player_id
execute as @e[tag=wire_anchor] if score @s player_id = #TEMP player_id run kill @s

# 落下ダメージ防止 (着地用に少し長めに付与)
effect give @s minecraft:slow_falling 2 0 true

# 音
playsound minecraft:entity.player.attack.sweep master @s ~ ~ ~ 1 1

# ▼▼▼ 追加: 風切り音を強制停止 ▼▼▼
# これで移動後の余韻をカットします
stopsound @s master minecraft:item.elytra.flying
# ▲▲▲ 追加ここまで ▲▲▲