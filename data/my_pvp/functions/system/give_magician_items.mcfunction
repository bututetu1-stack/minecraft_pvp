# --- 魔術師装備 ---

# 1. 魔術箒 (Slot 0)
item replace entity @s container.0 with minecraft:stick{magician_broom:1b,display:{Name:'{"text":"魔術箒","italic":false,"color":"light_purple","bold":true}',Lore:['{"text":"[Q]キー: 飛行開始/終了","color":"yellow"}','{"text":"飛行中: 通常=上昇 / Shift=下降","color":"white"}','{"text":"Cost: 5 MANA + 5/秒","color":"gray"}','{"text":"CT: 1s","color":"aqua"}']}} 1

# 2. 魔術本 (Slot 1)
item replace entity @s container.1 with minecraft:book{magician_book:1b,display:{Name:'{"text":"魔術本","italic":false,"color":"gold","bold":true}',Lore:['{"text":"[Q]キー: 炎玉発射","color":"yellow"}','{"text":"Cost: 5 MANA","color":"gray"}','{"text":"ダメージ: ハート1個分","color":"red"}','{"text":"CT: 1s","color":"aqua"}']}} 1

# 3. 初期マナ
scoreboard players set @s mana 50

# 4. クールダウン初期化
scoreboard players set @s cd_mag_broom 0
scoreboard players set @s cd_mag_book 0

# 5. 飛行状態初期化
tag @s remove mag_flying
scoreboard players set @s mag_fly_timer 0
