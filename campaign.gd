extends Node2D

#Erzeugen von Variablen
func get_name_file(filepath):
	
	#Alle Namensteile aus der externen TXT-Datei extrahieren.
	var file = File.new()
	file.open(filepath,file.READ)
	var content = file.get_as_text()
	var content_array = content.split("\n")
	file.close()
	
	#Namensteile zu ihrem "Ort" im Namen zuteilen.
	var array_name
	var start = []
	var middle = []
	var end = []
	for wordpart in content_array:
		match wordpart:
			"//START":
				array_name = start
			"//MIDDLE":
				array_name = middle
			"//END":
				array_name = end
		if !wordpart.begins_with("//") && wordpart != "":
			match array_name:
				start:
					start.append(wordpart)
				middle:
					middle.append(wordpart)
				end:
					end.append(wordpart)
	return [start, middle, end]

func get_building_name_file(filepath):
	
	#Alle Namensteile aus der externen TXT-Datei extrahieren.
	var file = File.new()
	file.open(filepath,file.READ)
	var content = file.get_as_text()
	var content_array = content.split("\n")
	file.close()
	
	#Namensteile zu ihrem "Ort" im Namen zuteilen.
	var array_name
	var noun_singular = []
	var noun_plural = []
	var adjective = []
	var adjective_singular = []
	var adjective_plural = []
	for wordpart in content_array:
		match wordpart:
			"//NOUN SINGULAR":
				array_name = noun_singular
			"//NOUN PLURAL":
				array_name = noun_plural
			"//ADJECTIVE":
				array_name = adjective
		if !wordpart.begins_with("//") && wordpart != "":
			match array_name:
				noun_singular:
					noun_singular.append(wordpart)
				noun_plural:
					noun_plural.append(wordpart)
				adjective:
					var adjective_parts = wordpart.split(",")
					adjective_singular.append(adjective_parts[0])
					adjective_plural.append(adjective_parts[1])
	return [noun_singular, noun_plural, adjective_singular, adjective_plural]

func get_road_name_file(filepath):
	
	#Alle Namensteile aus der externen TXT-Datei extrahieren.
	var file = File.new()
	file.open(filepath,file.READ)
	var content = file.get_as_text()
	var content_array = content.split("\n")
	file.close()
	
	#Namensteile zu ihrem "Ort" im Namen zuteilen.
	var array_name
	var noun = []
	var adjective_front = []
	var adjective_rear = []
	var description = []
	for wordpart in content_array:
		match wordpart:
			"//NOUN":
				array_name = noun
			"//ADJECTIVE FRONT":
				array_name = adjective_front
			"//ADJECTIVE BACK":
				array_name = adjective_rear
			"//DESCRIPTION":
				array_name = description
		if !wordpart.begins_with("//") && wordpart != "":
			match array_name:
				noun:
					noun.append(wordpart)
				adjective_front:
					adjective_front.append(wordpart)
				adjective_rear:
					adjective_rear.append(wordpart)
				description:
					description.append(wordpart)
	return [noun, adjective_front, adjective_rear, description]

func get_kind_of_place(filepath):
	
	var file = File.new()
	file.open(filepath,file.READ)
	var content = file.get_as_text()
	var content_array = content.split("\n")
	file.close()
	return content_array

func get_person(filepath):
	
	#Alle Namensteile aus der externen TXT-Datei extrahieren.
	var file = File.new()
	file.open(filepath,file.READ)
	var content = file.get_as_text()
	var content_array = content.split("\n")
	file.close()
	
	#Namensteile zu ihrem "Ort" im Namen zuteilen.
	var array_name
	var firstname_male = []
	var firstname_female = []
	var middlename_male = []
	var middlename_female = []
	var lastname = []
	var nickname = []
	var race = []
	var problem = []
	for wordpart in content_array:
		match wordpart:
			"//FIRSTNAME MALE":
				array_name = firstname_male
			"//FIRSTNAME FEMALE":
				array_name = firstname_female
			"//MIDDLENAME MALE":
				array_name = middlename_male
			"//MIDDLENAME FEMALE":
				array_name = middlename_female
			"//LASTNAME":
				array_name = lastname
			"//NICKNAME":
				array_name = nickname
			"//RACE":
				array_name = race
			"//PROBLEM":
				array_name = problem
		if !wordpart.begins_with("//") && wordpart != "":
			match array_name:
				firstname_male:
					firstname_male.append(wordpart)
				firstname_female:
					firstname_female.append(wordpart)
				middlename_male:
					middlename_male.append(wordpart)
				middlename_female:
					middlename_female.append(wordpart)
				lastname:
					lastname.append(wordpart)
				nickname:
					nickname.append(wordpart)
				race:
					race.append(wordpart)
				problem:
					problem.append(wordpart)
	return [firstname_male,firstname_female,middlename_male,middlename_female,lastname,nickname,race,problem]


#Verwenden von Variablen
func generate_place_name(name_start, name_middle, name_end):
	
	#Muss gecallt werden damit randi() tatsächlich funktioniert!
	randomize()
	
	#Der tatsächliche Name wird generiert.
	var has_middle_part = randi() % 2
	var world_name = ""
	
	world_name += name_start[randi() % name_start.size()]
	if has_middle_part == 1:
		world_name += name_middle[randi() % name_middle.size()]
	world_name += name_end[randi() % name_end.size()]
	return world_name

func generate_person_name(firstname_male,firstname_female,middlename_male,middlename_female,lastname,nickname,race,has_problem,problem):
	
	randomize()
	var male_or_female = randi() % 2
	var has_middlename = randi() % 2
	var has_nickname = randi() % 2
	var full_name = ""
	if male_or_female == 1:
		full_name += firstname_female[randi() % firstname_female.size()] + " "
		if has_middlename == 1:
			full_name += middlename_female[randi() % middlename_female.size()] + " "
		if has_nickname == 1:
			full_name += "\"" + nickname[randi() % nickname.size()] + "\" "
		full_name += lastname[randi() % lastname.size()]
		full_name += ", weiblicher " + race[randi() % race.size()]
		if has_problem == true:
			full_name += ", der " +  problem[randi() % problem.size()] + "."
	else:
		full_name +=  firstname_male[randi() % firstname_male.size()] + " "
		if has_middlename == 1:
			full_name +=  middlename_male[randi() % middlename_male.size()] + " "
		if has_nickname == 1:
			full_name +=  "\"" + nickname[randi() % nickname.size()] + "\" "
		full_name +=  lastname[randi() % lastname.size()]
		full_name += ", männlicher " + race[randi() % race.size()]
		if has_problem == true:
			full_name += ", der " +  problem[randi() % problem.size()] + "."
	return full_name

func generate_building_name(noun_singular, noun_plural, adjective_singular, adjective_plural):
	
	randomize()
	var singular_or_plural = randi() % 2
	var building_name
	if singular_or_plural == 1:
		var inbuild_name = noun_plural[randi() % noun_plural.size()]
		var inbuild_adjective = adjective_plural[randi() % adjective_plural.size()]
		building_name = inbuild_name.split(" ")[0] + " " + inbuild_adjective + " " + inbuild_name.split(" ")[1]
	else:
		var inbuild_name = noun_singular[randi() % noun_singular.size()]
		var inbuild_adjective = adjective_singular[randi() % adjective_singular.size()]
		building_name = inbuild_name.split(" ")[0] + " " + inbuild_adjective + " " + inbuild_name.split(" ")[1]
	return building_name

func generate_kind_of_place(place_start, place_middle, place_end, content):
	
	randomize()
	var full_place_name = ""
	full_place_name += content[randi() % content.size()] + " "
	full_place_name += generate_place_name(place_start, place_middle, place_end)
	return full_place_name

func generate_companion(firstname_male,firstname_female,middlename_male,middlename_female,lastname,nickname,race,problem):
	
	var has_problem = true
	var companion_name = generate_person_name(firstname_male,firstname_female,middlename_male,middlename_female,lastname,nickname,race,has_problem,problem)
	return companion_name

func generate_road(noun, adjective_front, adjective_rear, description):
	
	randomize()
	var front_or_rear = randi() % 2
	var has_description = randi() % 2
	var road_name = ""
	if front_or_rear == 1:
		road_name += noun[randi() % noun.size()] + " "
		road_name += adjective_rear[randi() % adjective_rear.size()]
		if has_description == 1:
			road_name += ", " + road_name.left(3).to_lower() + " " + description[randi() % description.size()]
	else:
		var the_name = noun[randi() % noun.size()].split(" ")
		road_name += the_name[0] + " " + adjective_front[randi() % adjective_front.size()] + the_name[1].to_lower()
		if has_description == 1:
			road_name += ", " + the_name[0].to_lower() + " " + description[randi() % description.size()]
	return road_name


func _ready():
	
	#Variablen werden erzeugt
	var world_name_values = get_name_file("res://campaign/placename.txt")
	var world_start = world_name_values[0]
	var world_middle = world_name_values[1]
	var world_end = world_name_values[2]
	var kind = get_kind_of_place("res://campaign/kindofarea.txt")
	var building_name_values = get_building_name_file("res://campaign/buildingname.txt")
	var noun_singular = building_name_values[0]
	var noun_plural = building_name_values[1]
	var adjective_singular = building_name_values[2]
	var adjective_plural = building_name_values[3]
	var person_values = get_person("res://campaign/persondata.txt")
	var firstname_male = person_values[0]
	var firstname_female = person_values[1]
	var middlename_male = person_values[2]
	var middlename_female = person_values[3]
	var lastname = person_values[4]
	var nickname = person_values[5]
	var race = person_values[6]
	var problem = person_values[7]
	var road_values = get_road_name_file("res://campaign/roadname.txt")
	var road_noun = road_values[0]
	var road_adjective_front = road_values[1]
	var road_adjective_rear = road_values[2]
	var road_description = road_values[3]
	
	#Variablen werden verwendet
	print("Name der Welt: " + generate_place_name(world_start, world_middle, world_end))
	print("Name des Startgebiets: " + generate_kind_of_place(world_start, world_middle, world_end, kind))
	print("\nDIE STADT")
	print("Name der Stadt: " + generate_place_name(world_start, world_middle, world_end))
	print("Name des Gasthauses: " + generate_building_name(noun_singular, noun_plural, adjective_singular, adjective_plural))
	print("Name der Kontaktperson im Gasthaus: " + generate_companion(firstname_male,firstname_female,middlename_male,middlename_female,lastname,nickname,race,problem))
	print("\nGEOGRAFIE")
	print("Name der Hauptstraße: " + generate_road(road_noun, road_adjective_front, road_adjective_rear, road_description))
	


	#https://donjon.bin.sh/fantasy/my_campaign/
	#https://donjon.bin.sh/fantasy/random/#type=npc
