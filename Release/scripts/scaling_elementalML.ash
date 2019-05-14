script scaling_elementalML

element hot = $element[hot];
element cold = $element[cold];
element spooky = $element[spooky];
element sleaze = $element[sleaze];
element stench = $element[stench];
stat myStat = my_primestat();

if(!get_property("aen_aliasEL").to_boolean()) {
	cli_execute("alias el => run elementalML.ash");
	cli_execute("alias sel => run scaling_elementalML.ash");
	set_property("aen_aliasEL", "true");
}

// Special thanks to Phillammon for helping me with this!

float totalML() {
    return my_buffedstat(myStat) + monster_level_adjustment();
}

float calcML() {
	if(monster_level_adjustment() > 24) {
		return monster_level_adjustment() - 25;
	} else {
		return 0;
	}
}

float virginDMG() {
    return ((totalML() * calcML())/500)*1.05;
}

float damage(element ele) {
	if(virginDMG() == 0) {
		return 0;
	} else if(virginDMG() < 30) {
		return max(1,virginDMG() - (30*elemental_resistance(ele)/100));
	} else {
		return max(1,virginDMG() * (1-(elemental_resistance(ele)/100)));
	}
}

float rounder(float number, int place) {
	float value = round(number*10.0**-place)*10.0**place;
	return value;
}

void main() {
	if(!get_property("noEle").to_boolean() && user_confirm("Would you like to tell Aenimus that you're using this script? It would be nice to know, but feel free to say no.")) {
		notify aenimus;
		set_property("noEle", "true");
	} else {
		set_property("noEle", "true");
	}
	print("You will take approximately " + rounder(damage(hot),0) + " from a hot monster's initial elemental hit.", "red");
	print("You will take approximately " + rounder(damage(cold),0) + " from a cold monster's initial elemental hit.", "blue");
	print("You will take approximately " + rounder(damage(spooky),0) + " from a spooky monster's initial elemental hit.", "gray");
	print("You will take approximately " + rounder(damage(stench),0) + " from a stench monster's initial elemental hit.", "green");
	print("You will take approximately " + rounder(damage(sleaze),0) + " from a sleaze monster's initial elemental hit.", "purple");	
	print("Remember that this version is for scaling monsters.", "green");
	print("You can now also simply type sel in the CLI to run this script!.", "green");
}

