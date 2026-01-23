# ヒット成功
# エフェクト適用 (target_hitbox に対して実行させる)
# ただし、apply_effectは @a[tag=current_raycaster] を対象にするよう書かれている。
# ここでの @s は player (current_checker)
# current_checker と current_raycaster はタグ名が違うので注意。
# apply_effect を汎用的にするか、タグを合わせるか。

# タグを合わせる: check/main で current_raycaster を使うようにする。
# あるいはここで current_raycaster を付ける。

tag @s add current_raycaster
execute as @e[tag=target_hitbox,limit=1] run function my_pvp:roles/sculptor/raycast/apply_effect
tag @s remove current_raycaster
