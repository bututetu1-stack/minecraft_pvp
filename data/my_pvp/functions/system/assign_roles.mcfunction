# 1. 山札からランダムに1枚カードを選ぶ
tag @e[tag=selected_card] remove selected_card
tag @e[tag=role_card,limit=1,sort=random] add selected_card

# 2. メカニック割り当て
execute if entity @e[tag=selected_card,tag=card_mechanic] run function my_pvp:roles/mechanic/assign
# 割り当てが成功していたら(tag=role_assignedが付いていたら)、ここで終了
execute if entity @s[tag=role_assigned] run return 1

# 3. 忍者割り当て
execute if entity @e[tag=selected_card,tag=card_ninja] run function my_pvp:roles/ninja/assign
# 割り当てが成功していたら終了
execute if entity @s[tag=role_assigned] run return 1

# 4. 予備：カード切れやエラー等の最終手段
# ここまで来ても役職がない場合のみ実行される
function my_pvp:roles/ninja/assign

# 5. 使用済みカードの破棄
kill @e[tag=selected_card]