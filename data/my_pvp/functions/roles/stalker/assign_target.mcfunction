# 1. 候補の選定 (自分以外、かつ生存しているプレイヤー)
tag @a remove stalker_candidate

# 【修正】自分自身に一時的なタグを付与して識別する
# (距離判定 distance=..0.1 だと、実行座標(at)がずれていた場合に自分を含んでしまうため)
tag @s add temp_current_stalker

# 自分以外の観戦者でないプレイヤーを候補にする
execute as @a[gamemode=!spectator,tag=!temp_current_stalker] run tag @s add stalker_candidate

# 一時タグを削除
tag @s remove temp_current_stalker


# 2. 候補がいない場合 (全員死亡など)
# ※ソロプレイ時は候補が0人になるため、ここで「ターゲットが見つかりません」となります
execute unless entity @a[tag=stalker_candidate] run tellraw @s [{"text":"[Stalker] ","color":"dark_red"},{"text":"ターゲットが見つかりません...","color":"gray"}]
execute unless entity @a[tag=stalker_candidate] run scoreboard players set @s target_id 0
execute unless entity @a[tag=stalker_candidate] run return 0

# 3. ランダムに1名選出
tag @a remove stalker_target_temp
tag @r[tag=stalker_candidate] add stalker_target_temp

# 4. IDを保存
scoreboard players operation #TEMP player_id = @e[tag=stalker_target_temp,limit=1] player_id
scoreboard players operation @s target_id = #TEMP player_id

# 5. 通知
execute at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 0.5
tellraw @s [{"text":"[Stalker] ","color":"dark_red"},{"text":"新たなターゲット: ","color":"white"},{"selector":"@e[tag=stalker_target_temp]","color":"red","bold":true}]