# 1. 山札からランダムに1枚選ぶ
# 自分(@s)にタグ付けをするため、選んだカード(@e)を一時的にマークします
tag @e[tag=role_card] remove selected_card
tag @e[tag=role_card,limit=1,sort=random] add selected_card

# 2. 選んだカードの種類を見て、自分に役職を割り当てる
execute if entity @e[tag=selected_card,tag=card_mechanic] run function my_pvp:roles/mechanic/assign


# 4. 引いたカードを破り捨てる（重複防止）
kill @e[tag=selected_card]