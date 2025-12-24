# 1. 抽選
tag @e[tag=role_card] remove selected_card
tag @e[tag=role_card,limit=1,sort=random] add selected_card

# 2. 割り当て
execute if entity @e[tag=selected_card,tag=card_mechanic] run function my_pvp:roles/mechanic/assign
# ソルジャー分岐を削除、忍者を追加
execute if entity @e[tag=selected_card,tag=card_ninja] run function my_pvp:roles/ninja/assign

# 3. 保険 (デフォルト: 忍者)
execute unless entity @s[tag=role_assigned] run function my_pvp:roles/ninja/assign

# 4. 破棄
kill @e[tag=selected_card]