# --- 区切り線 (12 Rays, 30度刻み) ---
# White boundaries
execute rotated ~0 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~30 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~60 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~90 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~120 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~150 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~180 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~210 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~240 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~270 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~300 0 run function my_pvp:events/roulette/draw_ray
execute rotated ~330 0 run function my_pvp:events/roulette/draw_ray

# --- セクターの描画 (Filled) ---
# Each sector center is at +15 degrees from the Ray

# 0. Red (Damage)
execute rotated ~15 0 run function my_pvp:events/roulette/draw_sector {r:1.0, g:0.0, b:0.0}
# 1. Blue (Heal)
execute rotated ~45 0 run function my_pvp:events/roulette/draw_sector {r:0.0, g:0.0, b:1.0}
# 2. Gold (Bonus)
execute rotated ~75 0 run function my_pvp:events/roulette/draw_sector {r:1.0, g:0.8, b:0.0}
# 3. Green (Speed)
execute rotated ~105 0 run function my_pvp:events/roulette/draw_sector {r:0.0, g:1.0, b:0.0}
# 4. Gray (Slowness)
execute rotated ~135 0 run function my_pvp:events/roulette/draw_sector {r:0.5, g:0.5, b:0.5}
# 5. Purple (Heavy Damage)
execute rotated ~165 0 run function my_pvp:events/roulette/draw_sector {r:0.5, g:0.0, b:0.5}
# 6. Aqua (Full Heal)
execute rotated ~195 0 run function my_pvp:events/roulette/draw_sector {r:0.0, g:1.0, b:1.0}
# 7. White (Jackpot)
execute rotated ~225 0 run function my_pvp:events/roulette/draw_sector {r:1.0, g:1.0, b:1.0}
# 8. Yellow (Levitation)
execute rotated ~255 0 run function my_pvp:events/roulette/draw_sector {r:1.0, g:1.0, b:0.0}
# 9. Black (Blindness)
execute rotated ~285 0 run function my_pvp:events/roulette/draw_sector {r:0.0, g:0.0, b:0.0}
# 10. Dark Red (Strength)
execute rotated ~315 0 run function my_pvp:events/roulette/draw_sector {r:0.5, g:0.0, b:0.0}
# 11. Dark Gray (Weakness)
execute rotated ~345 0 run function my_pvp:events/roulette/draw_sector {r:0.2, g:0.2, b:0.2}

# --- 固定ポインター (Static Pointer) ---
# 南 (0 deg local? No, South is Z+)
execute rotated 0 0 run particle minecraft:block_marker{block_state:"minecraft:redstone_block"} ^ ^ ^50 0 0 0 0 1 force
execute rotated 0 0 run particle minecraft:flame ^ ^ ^48 0 0 0 0.05 10 force
