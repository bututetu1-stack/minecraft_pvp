# キル確定処理
# @s = 被害者 (died player)

# 加害者IDを取得
scoreboard players operation #KILLER_ID temp = @s last_attacker_id
# 二重処理防止のためにIDリセット
scoreboard players set @s last_attacker_id 0

# 直前にプレイヤーから攻撃されていた場合は、バニラのキル数に既に加算されているので何もしない
execute on attacker if entity @s[type=player] run return 0

# 加害者にキルスコア加算
execute as @a if score @s player_id = #KILLER_ID temp run scoreboard players add @s kills 1
execute as @a if score @s player_id = #KILLER_ID temp run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 1

# キルログ表示 (オプション)
# execute as @a if score @s player_id = #KILLER_ID temp run tellraw @a ...
