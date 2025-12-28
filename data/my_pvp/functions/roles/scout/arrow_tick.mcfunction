# --- 【追加】常にダメージを無効化し続ける (攻撃判定防止) ---
# 毎tickダメージを0に上書きすることで、万が一当たっても0ダメージにします
data merge entity @s {damage:0.0d}

# 接地(inGround:1b)したらアンカー設置
execute if entity @s[nbt={inGround:1b}] run function my_pvp:roles/scout/deploy_anchor

# 一定時間(5秒)刺さらなかったら消滅
scoreboard players add @s gadget_life 1
execute if score @s gadget_life matches 100.. run kill @s