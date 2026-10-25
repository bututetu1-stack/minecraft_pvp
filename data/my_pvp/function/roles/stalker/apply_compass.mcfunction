# マクロ: コンパスのlodestone_tracker座標のみを更新 (item replace せず)
# 引数: x, y, z (storage my_pvp:stalker_macro)
# data modify でコンポーネントだけ書き換えるため、アイテム自体は再生成されず
# インベントリの「跳ねる」現象が発生しない

# Inventory 内の追跡コンパスエントリを検索して座標更新
$data modify entity @s Inventory[{components:{"minecraft:custom_data":{is_tracking_compass:1b}}}].components."minecraft:lodestone_tracker".target.pos set value [I;$(x),$(y),$(z)]
