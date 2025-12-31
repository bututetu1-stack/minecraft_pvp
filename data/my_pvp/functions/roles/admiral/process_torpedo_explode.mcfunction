# --- 爆発処理 ---
execute unless entity @s[tag=explode_now] run return 0

# 攻撃主(飼い主)特定
scoreboard players operation #OWNER_ID temp = @s player_id
tag @a remove attacker_temp
execute as @a if score @s player_id = #OWNER_ID temp run tag @s add attacker_temp

# 演出
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 2 1
particle minecraft:explosion_emitter ~ ~ ~ 1 0 0 0 1

# ▼ ダメージ処理 (Owner継承方式) ▼
summon area_effect_cloud ~ ~ ~ {Tags:["dmg_proxy"],Duration:5}

# Owner設定 (プロキシ用)
# 修正: ポイント確実化のため、バニラの自動判定を行わせないようOwner設定は削除(またはコメントアウト)
# execute if entity @p[tag=attacker_temp] run data modify entity @e[tag=dmg_proxy,limit=1] Owner set from entity @p[tag=attacker_temp,limit=1] UUID

# 名前設定 (「酸素魚雷」など)
data modify entity @e[tag=dmg_proxy,limit=1] CustomName set value '{"text":"酸素魚雷","color":"aqua","bold":true}'

# ダメージ実行 & ポイント手動判定
# 1. 死亡前のデス数を記録
execute as @a[distance=..4] run scoreboard players operation @s temp = @s deaths

# 2. プロキシ経由でダメージを実行 (by @p は使用しない)
execute as @a[distance=..4] run damage @s 8 minecraft:player_explosion by @e[tag=dmg_proxy,limit=1] from @e[tag=dmg_proxy,limit=1]

# 3. 死亡判定: deathsが増えていればキルとみなす
# ※自爆(自分のID=OWNER_ID)の場合は除外
execute as @a[distance=..4] if score @s deaths > @s temp unless score @s player_id = #OWNER_ID temp as @a if score @s player_id = #OWNER_ID temp run scoreboard players add @s kills 1

# 消滅
kill @e[tag=dmg_proxy]
tag @a remove attacker_temp
kill @s