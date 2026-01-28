# Macro: draw_sector using dust
# Args: r, g, b

# Center of Sector is checked at rotated ~15 0.
# We draw particles with spread to fill the wedge.

# Inner Circle (Radius 5-10)
$particle dust{color:[$(r),$(g),$(b)],scale:2} ^ ^ ^8 2 0 2 0 10

# Mid Circle (Radius 15-25)
$particle dust{color:[$(r),$(g),$(b)],scale:3} ^ ^ ^20 5 0 5 0 20

# Outer Circle (Radius 30-40)
$particle dust{color:[$(r),$(g),$(b)],scale:4} ^ ^ ^35 9 0 9 0 30

# Edge (Radius 45-50)
$particle dust{color:[$(r),$(g),$(b)],scale:4} ^ ^ ^48 12 0 12 0 30
