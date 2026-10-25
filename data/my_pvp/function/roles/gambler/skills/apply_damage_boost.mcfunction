# 通常攻撃のダメージ2倍処理 (運命のコインで利確した後の、次の攻撃1回)
# @s = attacker (Gambler with damage_boost=1, at @s)

# 1. 今回の攻撃ダメージを算出 (damage_dealt は 0.1 単位)
scoreboard players operation #dmg temp = @s damage_dealt
scoreboard players operation #dmg temp -= @s last_damage_dealt

# 2. ダメージが0以下の場合は処理しない (念のため)
execute if score #dmg temp matches ..0 run return 0

# 3. 殴った相手を特定 (6m以内で直前に被弾した一番近いプレイヤー)
tag @a remove boost_victim
tag @s add boost_attacker
execute as @a[distance=..6,tag=!boost_attacker,gamemode=!spectator,nbt=!{HurtTime:0s},limit=1,sort=nearest] run tag @s add boost_victim

# 4. 追加ダメージ (今回与えたダメージと同じ量 = 合計2倍)
# my_pvp:penalty は無敵時間・防具を無視するので、被弾直後でも通る
execute store result storage my_pvp:macro boost.amount double 0.1 run scoreboard players get #dmg temp
execute if entity @a[tag=boost_victim] run tellraw @s {"text":"[Fate] ダメージ2倍！","color":"aqua","bold":true}
execute as @a[tag=boost_victim] run function my_pvp:roles/gambler/skills/apply_damage_boost_macro with storage my_pvp:macro boost

# 5. フラグ消費 & 後処理 (相手が見つからなかった場合は次の攻撃に持ち越す)
execute if entity @a[tag=boost_victim] run scoreboard players set @s damage_boost 0
tag @s remove boost_attacker
tag @a remove boost_victim
