# オール・イン 失敗
# @s = player

tellraw @s {"text":"[All-In] 失敗... (HPが1になります)","color":"gray","bold":true}

# [重要] game_logicよりも先にタグを付けないと、game_logicで「HPが40じゃない！」と判定されてapply_statusが呼ばれてしまう可能性がある。
# しかし、コマンドの実行順は関数呼び出し順による。game_logic -> gambler_main -> this function の順なら、
# 次のtickのgame_logicまで猶予があるはず。
# 念の為、タグ付与を最優先にする。

tag @s add ignore_status_check
scoreboard players set @s bj_debuff_timer 100

# 効果: HP -> 1
attribute @s minecraft:generic.max_health base set 1.0

tellraw @s {"text":"[All-In] 失敗... HPが1になりました","color":"gray"}

effect give @s minecraft:slowness 5 1 true
effect give @s minecraft:weakness 5 1 true
