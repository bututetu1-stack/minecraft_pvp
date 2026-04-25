# 残心構え中の毎tick処理

# 残り時間消化
scoreboard players remove @s sam_zanshin_active 1

# 構え中の演出 (毎tick軽め)
particle minecraft:dust{color:[0.3,0.6,1.0],scale:0.6} ~ ~1.2 ~ 0.4 0.4 0.4 0 3 force
particle minecraft:enchant ~ ~1.5 ~ 0.3 0.3 0.3 0.3 1 force

# 構えを離した(右クリック解除)場合は終了
execute unless entity @s[predicate=my_pvp:is_blocking] run function my_pvp:roles/samurai/end_zanshin

# 被弾検知 (damage_taken) → 反撃成功
execute if score @s damage_taken matches 1.. run function my_pvp:roles/samurai/zanshin_counter

# 時間切れ
execute if score @s sam_zanshin_active matches ..0 run function my_pvp:roles/samurai/end_zanshin
