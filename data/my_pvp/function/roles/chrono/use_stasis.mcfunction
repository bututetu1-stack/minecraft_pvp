# CTセット (30秒 = 600tick)
scoreboard players set @s cd_chrono_stasis 600

# 音とアナウンス
playsound minecraft:block.beacon.deactivate master @a ~ ~ ~ 2 0.5
tellraw @a [{"text":"時よ、止まれ！ (Time Stop: 10s)","color":"yellow","bold":true}]

# --- 時空の静止フィールド(マーカー)の設置 ---
# 寿命200tick (10秒) のエリアエフェクトクラウドを設置
# 発動地点に固定
summon area_effect_cloud ~ ~ ~ {Tags:["stasis_center"],Duration:200}