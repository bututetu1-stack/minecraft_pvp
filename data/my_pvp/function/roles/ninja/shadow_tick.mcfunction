# 凍結中は処理をスキップ
execute if entity @s[tag=is_frozen] run return 0

# 左クリック（攻撃）されたか検知
# Interactionエンティティの左クリック情報は "attack" タグに入ります
execute if data entity @s attack run function my_pvp:roles/ninja/shadow_damage