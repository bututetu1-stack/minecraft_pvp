# --- ギャンブラー 上昇スキル: コイン跳躍 (Coin Flip Jump) ---
# コイン投げで運命を試す。70%通常、30%ジャックポット高跳び

# 1. スニークスコアリセット
scoreboard players set @s sneak_time 0

# 2. CDチェック
execute if score @s cd_gambler_jump matches 1.. run return 0

# 3. CDセット (12秒 = 240tick)
scoreboard players set @s cd_gambler_jump 240

# 4. 乱数生成 (一時マーカーのUUIDから 0-99)
summon marker ~ ~ ~ {Tags:["coin_flip_seed"]}
execute store result score #COIN_FLIP temp run data get entity @e[tag=coin_flip_seed,limit=1] UUID[0]
scoreboard players set #COIN_MOD temp 100
scoreboard players operation #COIN_FLIP temp %= #COIN_MOD temp
execute if score #COIN_FLIP temp matches ..-1 run scoreboard players add #COIN_FLIP temp 100
kill @e[tag=coin_flip_seed]

# 5. 共通演出 (コイン投げ)
playsound minecraft:entity.experience_orb.pickup master @a ~ ~ ~ 1.5 1.8
particle minecraft:dust{color:[1.0,0.85,0.0],scale:1.0} ~ ~1 ~ 0.4 0.4 0.4 1 25 force
particle minecraft:wax_off ~ ~1 ~ 0.3 0.3 0.3 0.1 15 force

# 6. 結果分岐
# 6a. ジャックポット (30%): amplifier 18 (より高い) + ボーナス
execute if score #COIN_FLIP temp matches 0..29 run effect give @s minecraft:levitation 1 18 true
execute if score #COIN_FLIP temp matches 0..29 run scoreboard players add @s coins 3
execute if score #COIN_FLIP temp matches 0..29 run playsound minecraft:entity.player.levelup master @a ~ ~ ~ 1.5 2
execute if score #COIN_FLIP temp matches 0..29 at @s run particle minecraft:firework ~ ~1 ~ 0.5 0.5 0.5 0.3 40 force
execute if score #COIN_FLIP temp matches 0..29 run tellraw @s [{"text":"[JACKPOT] ","color":"gold","bold":true},{"text":"高跳び！ +3 coins","color":"yellow"}]
execute if score #COIN_FLIP temp matches 0..29 run title @s actionbar [{"text":"[コイン跳躍] ","color":"green","bold":true},{"text":"ジャックポット！","color":"gold","bold":true}]

# 6b. 通常 (70%): 基準 amplifier 15
execute if score #COIN_FLIP temp matches 30..99 run effect give @s minecraft:levitation 1 15 true
execute if score #COIN_FLIP temp matches 30..99 run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 1 1.5
execute if score #COIN_FLIP temp matches 30..99 run title @s actionbar [{"text":"[コイン跳躍] ","color":"green","bold":true},{"text":"賭け開始","color":"yellow"}]
