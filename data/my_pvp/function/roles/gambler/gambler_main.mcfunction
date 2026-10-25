# 1. コインタイマー (オートリチャージ 1 coin / 1s)

# --- 役職固有 上昇スキル: コイン跳躍 ---
execute if score @s cd_gambler_jump matches 1.. run scoreboard players remove @s cd_gambler_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/gambler/use_jump
# 20 ticks = 1 second
scoreboard players add @s coins_timer 1
execute if score @s coins_timer matches 20.. run scoreboard players add @s coins 1
execute if score @s coins_timer matches 20.. run scoreboard players set @s coins_timer 0

# 最大200枚
execute if score @s coins matches 201.. run scoreboard players set @s coins 200

# 2. アクションバー表示
title @s actionbar [{"text":"Coins: ","color":"gold","bold":true},{"score":{"name":"@s","objective":"coins"},"color":"yellow"},{"text":"/200","color":"gold"}]

# 3. ブラックジャックのアクション制御
# 3秒 (60 ticks) 放置 -> STAY
execute if score @s bj_state matches 1 run scoreboard players add @s bj_timer 1
execute if score @s bj_state matches 1 if score @s bj_timer matches 60.. run function my_pvp:roles/gambler/skills/blackjack/stay

# タイマー表示 (残り秒数)
execute if score @s bj_state matches 1 run title @s actionbar [{"text":"[BJ] STAYまで: ","color":"yellow"},{"score":{"name":"@s","objective":"bj_timer"},"color":"red"},{"text":"/60","color":"gray"}]

# Fキー(Swap Item)検知は廃止
# execute if score @s bj_state matches 1 if score @s swap_item matches 1.. run function my_pvp:roles/gambler/skills/blackjack/stay
# scoreboard players set @s swap_item 0

# 4. HP回復タイマー & BJデバフ処理
# Burstは即時ダメージになったので、このタイマーはAll-In Fail専用となるが、仕組みは共通で良い。
execute if score @s bj_debuff_timer matches 1.. run scoreboard players remove @s bj_debuff_timer 1
execute if score @s bj_debuff_timer matches 1 run function my_pvp:roles/gambler/skills/blackjack/restore_hp

# BJデバフ: 被ダメージ増加処理
# bj_hit_cd (クールダウン) を減らす
execute if score @s bj_hit_cd matches 1.. run scoreboard players remove @s bj_hit_cd 1
# ダメージを受けていて(damage_taken >= 1)、かつデバフ中(tag=bj_debuff)、CT中でなければ発動
execute if score @s damage_taken matches 1.. if entity @s[tag=bj_debuff] unless score @s bj_hit_cd matches 1.. run function my_pvp:roles/gambler/skills/apply_bj_penalty
# ダメージを受けていなければスコアはリセット (CT中でもリセットして蓄積を防ぐ)
execute if score @s damage_taken matches 1.. run scoreboard players set @s damage_taken 0

# 5. 戦争 (War) 発動判定 (攻撃時)
# メインハンドに赤色の染料を持ち、かつ攻撃を与えた瞬間に発動
# 5. 戦争 (War) 発動判定 (攻撃時)
# メインハンドに赤色の染料を持ち、かつ攻撃を与えた瞬間に発動
# (Warが発動した場合はWar内でdamage_boostが消費されるため、下の汎用判定は不発になる)
execute if score @s damage_dealt > @s last_damage_dealt if items entity @s weapon.mainhand minecraft:red_dye run function my_pvp:roles/gambler/skills/war

# 汎用ダメージブースト判定 (War以外で攻撃した場合)
execute if score @s damage_dealt > @s last_damage_dealt if score @s damage_boost matches 1 run function my_pvp:roles/gambler/skills/apply_damage_boost

# 【追加】攻撃ヒット時にコインを10枚付与
execute if score @s damage_dealt > @s last_damage_dealt run scoreboard players add @s coins 5
execute if score @s damage_dealt > @s last_damage_dealt run tellraw @s {"text":"[+] 5 Coins","color":"gold"}

# ステータス同期
scoreboard players operation @s last_damage_dealt = @s damage_dealt

# ルーレットのエフェクト進行は game_logic で行う (ここでも呼ぶと2倍速になる)

# 運命のコイン (Fate Coin) 進行
execute if score @s fate_streak matches 1.. run function my_pvp:roles/gambler/skills/fate_coin/tick
