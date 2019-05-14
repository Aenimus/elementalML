script elementalML

element hot = $element[hot];
element cold = $element[cold];
element spooky = $element[spooky];
element sleaze = $element[sleaze];
element stench = $element[stench];

if(!get_property("aen_aliasEL").to_boolean()) {
	cli_execute("alias el => run elementalML.ash");
	cli_execute("alias sel => run scaling_elementalML.ash");
	set_property("aen_aliasEL", "true");
}

// Special thanks to Phillammon for helping me with this!

/*float pow(float base, int exponent) {
	float result = 1.0;
	if(exponent == 0) {
		return 1.0;
	}

	for a from  1 to exponent {
		result = result * base;
	}
	return result;
}

float reduction(float your_relevant_elem_res) {
    if(your_relevant_elem_res < 4) {
		float res = your_relevant_elem_res/10;
		if(my_primestat() == $stat[mysticality]) {
			res = res + 0.05;
		}
        return 1 - res;
    } else {
		 float res = your_relevant_elem_res - 4;
		 float fraction = 5.0/6;
		 float first = pow(fraction, res);
		 float second = 0.1 + (0.5 * first);
		if(my_primestat() == $stat[mysticality]) {
			second = second - 0.05;
		}
        return second;
    }
} */

float totalML(float monster_natural_ML) {
    return monster_natural_ML + monster_level_adjustment();
}

float calcML() {
	if(monster_level_adjustment() > 24) {
		return monster_level_adjustment() - 25;
	} else {
		return 0;
	}
}

float virginDMG(float monster_natural_ML) {
    return ((totalML(monster_natural_ML) * calcML())/500)*1.05;
}

float damage(float monster_natural_ML, element ele) {
	if(virginDMG(monster_natural_ML) == 0) {
		return 0;
	} else if(virginDMG(monster_natural_ML) < 30) {
		return max(1,virginDMG(monster_natural_ML) - (30*elemental_resistance(ele)/100));
	} else {
		return max(1,virginDMG(monster_natural_ML) * (1-(elemental_resistance(ele)/100)));
	}
}

float rounder(float number, int place) {
	float value = round(number*10.0**-place)*10.0**place;
	return value;
}

void main(string monsterOrML) {
	if(!get_property("noEle").to_boolean()) {
		if (user_confirm("Would you like to tell Aenimus that you're using this script? It would be nice to know, but feel free to say no.")) {
			notify aenimus;
		}
		set_property("noEle", "true");
	}
	float monster_natural_ML = to_float(monsterOrML);
	monster chosen_monster = to_monster(monsterOrML);
	if (monster_natural_ML == 0.0) {
		if (chosen_monster.defense_element != $element[none]) {
			print("You will take approximately " + rounder(damage(chosen_monster.raw_attack, chosen_monster.defense_element),0) + " from " + chosen_monster + "'s initial elemental hit.", "black");
		}
		else {
			print("Either that monster isn't elementally aligned, or we didn't understand what you said. Enter a monster name, or a base attack value.");
		}
	}
	else {
		print("You will take approximately " + rounder(damage(monster_natural_ML, hot),0) + " from a hot monster's initial elemental hit.", "red");
		print("You will take approximately " + rounder(damage(monster_natural_ML, cold),0) + " from a cold monster's initial elemental hit.", "blue");
		print("You will take approximately " + rounder(damage(monster_natural_ML, spooky),0) + " from a spooky monster's initial elemental hit.", "gray");
		print("You will take approximately " + rounder(damage(monster_natural_ML, stench),0) + " from a stench monster's initial elemental hit.", "green");
		print("You will take approximately " + rounder(damage(monster_natural_ML, sleaze),0) + " from a sleaze monster's initial elemental hit.", "purple");	
		print("Remember that the monster's natural ML is your mainstat for scalers.", "green");
		print("You can now also simply type el in the CLI to run this script!.", "green");
	}
}
