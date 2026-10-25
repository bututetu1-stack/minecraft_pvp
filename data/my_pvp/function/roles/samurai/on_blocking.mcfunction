# 残心の盾を構えている間、毎tick呼ばれる (my_pvp:roles/samurai_blocking 進捗の報酬)
# @s = player
# ※ 1.21.4 のエンティティフラグには is_blocking が無いため、using_item 進捗で構えを検知する
advancement revoke @s only my_pvp:roles/samurai_blocking
scoreboard players set @s sam_blocking 1
