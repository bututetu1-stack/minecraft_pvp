# 1. 山札からランダムに1枚カードを選ぶ
tag @e[tag=selected_card] remove selected_card
tag @e[tag=role_card,limit=1,sort=random] add selected_card

# 2. 選ばれたカード(@e[tag=selected_card])に対応する役職を割り当てる
# 機械工のカードだった場合
execute if entity @e[tag=selected_card,tag=card_mechanic] run function my_pvp:roles/mechanic/assign

# 忍者のカードだった場合
execute if entity @e[tag=selected_card,tag=card_ninja] run function my_pvp:roles/ninja/assign

# スカウトのカードだった場合
execute if entity @e[tag=selected_card,tag=card_scout] run function my_pvp:roles/scout/assign

# タンクのカードだった場合
execute if entity @e[tag=selected_card,tag=card_tank] run function my_pvp:roles/tank/assign

# バーサーカーのカードだった場合
execute if entity @e[tag=selected_card,tag=card_berserker] run function my_pvp:roles/berserker/assign

# 魔術師のカードだった場合
execute if entity @e[tag=selected_card,tag=card_magician] run function my_pvp:roles/magician/assign

# ストーカーのカードだった場合
execute if entity @e[tag=selected_card,tag=card_stalker] run function my_pvp:roles/stalker/assign

# 提督のカードだった場合
execute if entity @e[tag=selected_card,tag=card_admiral] run function my_pvp:roles/admiral/assign

# 【追加】 時空跳躍者のカードだった場合
execute if entity @e[tag=selected_card,tag=card_chrono] run function my_pvp:roles/chrono/assign

# 【追加】 彫刻家のカードだった場合
execute if entity @e[tag=selected_card,tag=card_sculptor] run function my_pvp:roles/sculptor/assign

# 3. 使用済みカードの破棄
kill @e[tag=selected_card]
