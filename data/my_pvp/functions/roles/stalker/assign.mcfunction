# 1. タグ付け
tag @s add stalker
tag @s add role_assigned

# 2. チャット通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『ストーカー』","color":"dark_red","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定
function my_pvp:roles/stalker/apply_status

# 4. 音 (変更)
# ウォーデンの心音（ドクン…）で緊張感を演出
execute at @s run playsound minecraft:entity.warden.heartbeat master @s ~ ~ ~ 2 0.8

# 決定音として、少し重い金属音を重ねる
execute at @s run playsound minecraft:block.respawn_anchor.charge master @s ~ ~ ~ 1 0.5