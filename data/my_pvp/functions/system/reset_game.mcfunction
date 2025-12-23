# 全員のスコアをリセット
scoreboard players reset @a kills
scoreboard players reset @a deaths
scoreboard players reset @a points
scoreboard players reset @a scrap
# クールダウン系リセット
scoreboard players reset @a cd_turret
scoreboard players reset @a cd_mine
scoreboard players reset @a cd_launcher
scoreboard players reset @a cd_snare

# インベントリクリア
clear @a

# エフェクトクリア
effect clear @a

# 設置されたガジェット・くじ・カード等を全消去
kill @e[tag=gadget]
kill @e[tag=gadget_hitbox]
kill @e[tag=role_card]

# タイマーリセット
scoreboard players set #GLOBAL match_timer 0
scoreboard players set #GLOBAL match_state 0