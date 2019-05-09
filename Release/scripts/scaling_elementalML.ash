script scaling_elementalML

element hot = $element[hot];
element cold = $element[cold];
element spooky = $element[spooky];
element sleaze = $element[sleaze];
element stench = $element[stench];
stat myStat = my_primestat();

// Special thanks to Phillammon for helping me with this!

float totalML() {
    return my_buffedstat(myStat) + monster_level_adjustment();
}

float calcML() {
    return monster_level_adjustment() - 25;
}

float virginDMG() {
    return (totalML() * calcML())/500;
}

float damage(element ele) {
    return  virginDMG() * (1-(elemental_resistance(ele)/100));
}

float rounder(float number, int place) {
	float value = round(number*10.0**-place)*10.0**place;
	return value;
}

void main() {
	if(!get_property("noAnus").to_boolean() && user_confirm("Would you like to tell Aenimus that you're using this script? It would be nice to know, but feel free to say no.")) {
		notify aenimus;
		set_property("noAnus", "true");
	} else {
		set_property("noAnus", "true");
	}
    print("You will take approximately " + rounder(damage(hot),-1) + " from a hot monster's initial elemental hit.", "red");
    print("You will take approximately " + rounder(damage(cold),-1) + " from a cold monster's initial elemental hit.", "blue");
    print("You will take approximately " + rounder(damage(spooky),-1) + " from a spooky monster's initial elemental hit.", "gray");
    print("You will take approximately " + rounder(damage(stench),-1) + " from a stench monster's initial elemental hit.", "green");
    print("You will take approximately " + rounder(damage(sleaze),-1) + " from a sleaze monster's initial elemental hit.", "purple");	
	print("Remember that this version is for scaling monsters.", "green");
}

