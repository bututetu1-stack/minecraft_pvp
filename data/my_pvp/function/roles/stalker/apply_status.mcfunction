# 最大体力を40に設定
attribute @s minecraft:max_health base set 40

# 全回復
effect give @s minecraft:instant_health 1 100 true
effect give @s minecraft:saturation 1 255 true

# --- 【重要】リスポーン時にターゲットを再抽選 ---
# 自分が死んで復活した際、心機一転して新しい獲物を狙います
function my_pvp:roles/stalker/assign_target