# 残心構え中の毎tick処理

# 残り時間消化
scoreboard players remove @s sam_zanshin_active 1

# 構えを離した(右クリック解除)場合は終了
execute unless score @s sam_blocking matches 1.. run function my_pvp:roles/samurai/end_zanshin

# 被弾検知 (damage_taken) → 反撃成功
execute if score @s damage_taken matches 1.. run function my_pvp:roles/samurai/zanshin_counter
# 盾で正面から防いだ場合は damage_taken ではなく damage_blocked_by_shield が増える
execute if entity @s[tag=sam_zanshin_guard] if score @s sam_shield_block matches 1.. run function my_pvp:roles/samurai/zanshin_counter

# 時間切れ
execute if score @s sam_zanshin_active matches ..0 run function my_pvp:roles/samurai/end_zanshin
