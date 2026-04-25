# 1. タグ付け
tag @s add berserker
scoreboard players set @s role_id 5
tag @s add role_assigned

# 2. 通知（これは最初の1回だけでOK）
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『バーサーカー』","color":"red","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定（切り出した関数を呼ぶ）
function my_pvp:roles/berserker/apply_status

# 4. その他初期化
attribute @s minecraft:attack_damage base set 1
scoreboard players set @s last_kills 0

# ▼▼▼ 【復活】ここを戻してください ▼▼▼
# リスポーン処理から分離したため、ここで初期化しても大丈夫です
scoreboard players set @s cd_ber_raid 0
scoreboard players set @s cd_ber_jump 0
scoreboard players set @s cd_super_jump 0
scoreboard players set @s sneak_time 0
# ▲▲▲▲▲▲

# 5. 音
execute at @s run playsound minecraft:entity.ravager.roar master @s ~ ~ ~ 1 1