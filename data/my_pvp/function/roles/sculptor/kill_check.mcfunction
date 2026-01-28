# 彫刻家のキル判定処理 (毎tick呼び出し)
# @s = player

# 1. タイマー減算
execute if score @s sculptor_hit_timer matches 1.. run scoreboard players remove @s sculptor_hit_timer 1

# 2. タイマー切れでIDリセット (10秒経過したら権利消失)
execute if score @s sculptor_hit_timer matches 0 run scoreboard players set @s last_attacker_id 0

# 3. 死亡判定 (deathsが増えた場合)
# システム側で deaths がリセットされるタイミングに注意。game_logic では計算後にリセットされているか？
# ここでは「deathsが1以上」かつ「last_attacker_id有効」なら処理する

execute if score @s deaths matches 1.. if score @s last_attacker_id matches 1.. run function my_pvp:roles/sculptor/process_kill
