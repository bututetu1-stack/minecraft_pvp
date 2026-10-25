# 集中スコープを覗いている間、毎tick呼ばれる (my_pvp:roles/sharpshooter_focus 進捗の報酬)
# @s = player
# ※ 1.21.4 のエンティティフラグには is_using_item が無いため、using_item 進捗で検知する
advancement revoke @s only my_pvp:roles/sharpshooter_focus
scoreboard players set @s sharp_using 1
