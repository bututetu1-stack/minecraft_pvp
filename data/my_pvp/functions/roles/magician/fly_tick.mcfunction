# シンプル版: `mag_flying` タグが付いているときだけ Levitation を付与します。
# （細かい上昇制御やスニーク判定は不要なため削除）

execute if entity @s[tag=mag_flying_true] run effect give @s minecraft:levitation 2 4 true
