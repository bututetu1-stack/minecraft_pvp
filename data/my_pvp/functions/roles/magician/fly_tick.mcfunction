# シンプル版: `mag_flying` タグが付いているときだけ Levitation を付与します。
# （細かい上昇制御やスニーク判定は不要なため削除）

execute if entity @s[tag=mag_flying] run effect give @s minecraft:levitation 2 1 true
