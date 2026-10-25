# CTセット (30秒 = 600tick)
scoreboard players set @s cd_chrono_stasis 600

# 音とアナウンス
playsound minecraft:block.beacon.deactivate master @a ~ ~ ~ 2 0.5
tellraw @a [{"text":"時よ、止まれ！ (Time Stop: 10s)","color":"yellow","bold":true}]

# --- 時空の静止フィールド(マーカー)の設置 ---
# 寿命200tick (10秒) のエリアエフェクトクラウドを設置
# 発動地点に固定
# ※ 1.20.5 以降は Particle を {type:..} の形式で書く必要がある (文字列だと無視されて既定のパーティクルが出ていた)
summon area_effect_cloud ~ ~ ~ {Tags:["stasis_center"],Duration:200,Particle:{type:"minecraft:block",block_state:{Name:"minecraft:air"}}}