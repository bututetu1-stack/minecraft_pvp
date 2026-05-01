# マクロ: コンパスを最新ターゲット座標で再作成 (slot 1 固定)
# 引数: x, y, z (storage my_pvp:stalker_macro)
# tracked:false で「ロードストーンが無くても保存座標を指す」挙動を保証
$item replace entity @s container.1 with minecraft:compass[minecraft:custom_data={is_tracking_compass:1b},minecraft:lodestone_tracker={target:{dimension:"minecraft:overworld",pos:[I;$(x),$(y),$(z)]},tracked:false},minecraft:custom_name='{"text":"追跡のコンパス","italic":false,"color":"gold"}'] 1
