# --- 狩りの時間 (Hunting Hour): 視線でターゲットを追い続けると強化される ---
# stalker_main から毎tick呼ばれる
# 呼び出し前に raycast が走り、命中時に #GAZE_HIT temp = 1 がセットされる前提

# 旧スタック値を保存 (変化検知用)
scoreboard players operation #OLD_STACKS temp = @s hunting_stacks

# 1. ヒット時: スタック増加 (最大3) + decay timer リセット
execute if score #GAZE_HIT temp matches 1 run scoreboard players set @s hunting_decay_timer 0
execute if score #GAZE_HIT temp matches 1 if score @s hunting_stacks matches ..2 run scoreboard players add @s hunting_stacks 1

# 2. ミス時: decay timer 加算、60tick (3秒) 経ったらスタック1減
execute if score #GAZE_HIT temp matches 0 run scoreboard players add @s hunting_decay_timer 1
execute if score @s hunting_decay_timer matches 60.. if score @s hunting_stacks matches 1.. run scoreboard players remove @s hunting_stacks 1
execute if score @s hunting_decay_timer matches 60.. run scoreboard players set @s hunting_decay_timer 0

# 3. スタック増減通知 (旧値と異なれば演出)
# 増加時
execute unless score @s hunting_stacks = #OLD_STACKS temp if score @s hunting_stacks matches 1.. if score #GAZE_HIT temp matches 1 run playsound minecraft:entity.warden.heartbeat master @s ~ ~ ~ 1.5 0.7
execute unless score @s hunting_stacks = #OLD_STACKS temp if score @s hunting_stacks matches 1.. if score #GAZE_HIT temp matches 1 at @s run particle minecraft:soul ~ ~1.5 ~ 0.4 0.5 0.4 0.05 12 force
# 3スタック達成時の特別演出
execute unless score @s hunting_stacks = #OLD_STACKS temp if score @s hunting_stacks matches 3 if score #GAZE_HIT temp matches 1 run playsound minecraft:entity.warden.roar master @s ~ ~ ~ 0.6 1.2
execute unless score @s hunting_stacks = #OLD_STACKS temp if score @s hunting_stacks matches 3 if score #GAZE_HIT temp matches 1 run tellraw @s [{"text":"[狩りの時間] ","color":"dark_red","bold":true},{"text":"獲物が逃げ場を失った…","color":"red"}]
# 減少時 (低下音)
execute unless score @s hunting_stacks = #OLD_STACKS temp if score #GAZE_HIT temp matches 0 run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.6 0.5

# 4. スタック数に応じたバフ付与 (毎tick更新で持続)
# stack 1: speed I
execute if score @s hunting_stacks matches 1.. run effect give @s minecraft:speed 1 0 true
# stack 2: + strength I
execute if score @s hunting_stacks matches 2.. run effect give @s minecraft:strength 1 0 true
# stack 3: speed II + regeneration I (上書き)
execute if score @s hunting_stacks matches 3 run effect give @s minecraft:speed 1 1 true
execute if score @s hunting_stacks matches 3 run effect give @s minecraft:regeneration 1 0 true

# 5. 常時の頭上パーティクル (スタック数 = 頭上の魂火の数)
execute if score @s hunting_stacks matches 1 at @s run particle minecraft:soul_fire_flame ~ ~2.3 ~ 0 0 0 0 1 force
execute if score @s hunting_stacks matches 2 at @s run particle minecraft:soul_fire_flame ~ ~2.3 ~ 0.2 0 0.2 0 2 force
execute if score @s hunting_stacks matches 3 at @s run particle minecraft:soul_fire_flame ~ ~2.3 ~ 0.3 0.1 0.3 0 4 force
