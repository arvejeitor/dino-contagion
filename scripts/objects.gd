extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var map = get_node("/root/game/principal/TileMap/objects")
const Fileloader = preload("FileLoader.gd") # Relative path
onready var file_loader = Fileloader.new()

func _ready():
	file_loader.parseFile()
	var level=file_loader.getLevelMatrix()
	placeTiles(level,file_loader.getLevelColumn(),file_loader.getLevelRow())
	print (file_loader.getLevelColumn())
	print (file_loader.getLevelRow())
	var tiles = get_used_cells()
	for pos in tiles:
		
		#get current cell index
		var idx = get_cell(pos.x,pos.y)
				
		#else
		var tgt = map_to_world(pos,false) #get world pos
		tgt = Vector2(tgt.x,tgt.y + 15) #offset to centralize tile
		
		var tile = Vector2(pos.x,pos.y)
		
#		Reemplazo los tiles por animaciones re copadas
		
#		Dino izquierda
		if (self.get_cellv(tile) == 29) and is_cell_x_flipped(tile.x, tile.y):
			ubicarDino(tile, "res://scenes/DinoFixedLeft.tscn")
			
#		Dino Derecha
		elif (self.get_cellv(tile) == 29) and not is_cell_x_flipped(tile.x, tile.y):
			ubicarDino(tile, "res://scenes/DinoFixedRight.tscn")
			
#		Dino de frente
		elif (self.get_cellv(tile) == 28):
			ubicarDino(tile, "res://scenes/DinoFixedFront.tscn")
			
#		Dino de espalda
		elif (self.get_cellv(tile) == 30):
			ubicarDino(tile, "res://scenes/DinoFixedBack.tscn")
			
#		Dino protagonista
		elif (self.get_cellv(tile) == 27):
			ubicarDino(tile, "res://scenes/DinoFirst.tscn")
			
#		El Jefe
		elif (self.get_cellv(tile) == 31):
			ubicarDino(tile, "res://scenes/DinoBoss.tscn")
			
	
	set_process(true) #cursor and player interactions
	set_process_input(true) #also cursor and player interactions
	
func ubicarDino(tile, scene):
	
	self.set_cellv(tile,-1)
	var dinoScene = load(scene)
	var dino = dinoScene.instance()		
	dino.z_index = 1
	dino.tile = tile
	dino.position = Vector2(map_to_world(tile).x + 150, map_to_world(tile).y + 250)
	self.call_deferred("add_child", dino)	
	global.dinos_fixed[tile] = [dino]

	
func placeTiles(elementos, columnas, filas):
	var index=0
	var tile=0
	
	for i in range(filas):
		for j in range(columnas):
			var posicion = Vector2(j-1,i)
			#tile=getTile(elementos[index])
			tile=getTile(elementos[index])
			if tile != 99:
				self.set_cellv(posicion, tile)
			if tile == 99:
				self.set_cellv(posicion, 29, true)
			index=index+1

func test():
	var position = Vector2(-1,0)
	var tile=3
	self.set_cellv(position, tile)
	
func getTile(elemento):
	match elemento:
		"library":
			return 3
		"chair":
			return 4			
		"filer":
			return 6			
		"pctable":
			return 8
		"plant":
			return 9
		"table":
			return 10
		"tableh1":
			return 11
		"tableh2":
			return 13
		"tableh3":
			return 15
		"tablev1":
			return 18
		"tablev2":
			return 20
		"tablev3":
			return 22
		"dino1":
			return 27
		"dinof":
			return 28
		"dinor":
			return 29
		"dinob":
			return 30
		"dinob2":
			return 31
		"dispenser":
			return 32
		"pannels":
			return 33			
		"tablev1p":
			return 34
		"tablev3p":
			return 35						
		"dinol":
			return 99
			
		_:
			return -1
	
func posicionValida(tile):
	return (tile.y <= global.ROWS and tile.y >= 0) and (tile.x <= global.COLUMNS and tile.x >= -1)
