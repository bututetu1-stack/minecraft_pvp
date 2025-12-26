# 1. グローバルカウンターが未設定なら初期化 (安全装置)
execute unless score #NEXT_ID player_id matches 1.. run scoreboard players set #NEXT_ID player_id 1

# 2. 自分のIDを取得
scoreboard players operation @s player_id = #NEXT_ID player_id

# 3. カウンターを1進める (次の人のため)
scoreboard players add #NEXT_ID player_id 1

# 4. 確認用ログ (IDがついたことを通知)
tellraw @a [{"text":"[System] ID Assigned: ","color":"gray"},{"selector":"@s"},{"text":" -> ","color":"gray"},{"score":{"name":"@s","objective":"player_id"},"color":"aqua"}]