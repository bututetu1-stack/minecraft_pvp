# ルーレットの12セクター（部品）を生成する

# 0. Red (Damage)
function my_pvp:events/roulette/summon_sector_group {offset:0, item:"minecraft:red_stained_glass"}
# 1. Blue (Heal)
function my_pvp:events/roulette/summon_sector_group {offset:30, item:"minecraft:blue_stained_glass"}
# 2. Gold (Bonus)
function my_pvp:events/roulette/summon_sector_group {offset:60, item:"minecraft:yellow_stained_glass"}
# 3. Green (Speed)
function my_pvp:events/roulette/summon_sector_group {offset:90, item:"minecraft:lime_stained_glass"}
# 4. Gray (Slowness)
function my_pvp:events/roulette/summon_sector_group {offset:120, item:"minecraft:gray_stained_glass"}
# 5. Purple (Heavy Damage)
function my_pvp:events/roulette/summon_sector_group {offset:150, item:"minecraft:purple_stained_glass"}
# 6. Aqua (Full Heal)
function my_pvp:events/roulette/summon_sector_group {offset:180, item:"minecraft:light_blue_stained_glass"}
# 7. White (Jackpot)
function my_pvp:events/roulette/summon_sector_group {offset:210, item:"minecraft:white_stained_glass"}
# 8. Yellow (Levitation) -> Used Yellow for Gold. Use Orange or Sponge? Use Orange Stained Glass.
function my_pvp:events/roulette/summon_sector_group {offset:240, item:"minecraft:orange_stained_glass"}
# 9. Black (Blindness)
function my_pvp:events/roulette/summon_sector_group {offset:270, item:"minecraft:black_stained_glass"}
# 10. Dark Red (Strength) -> Use Magenta? Or Pink? Use Pink.
function my_pvp:events/roulette/summon_sector_group {offset:300, item:"minecraft:pink_stained_glass"}
# 11. Dark Gray (Weakness) -> Use Light Gray.
function my_pvp:events/roulette/summon_sector_group {offset:330, item:"minecraft:light_gray_stained_glass"}
