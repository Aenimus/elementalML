script elementalML

element hot = $element[hot];
element cold = $element[cold];
element spooky = $element[spooky];
element sleaze = $element[sleaze];
element stench = $element[stench];

// Special thanks to Phillammon for helping me with this!

float pow(float base, int exponent) {
	float result = 1.0;
	if(exponent == 0) {
		return 1.0;
	}

	for a from  1 to exponent {
		result = result * base;
	}
	return result;
}

/*float reduction(float your_relevant_elem_res) {
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
    return monster_level_adjustment() - 25;
}

float virginDMG(float monster_natural_ML) {
    return (totalML(monster_natural_ML) * calcML())/500;
}

float damage(float monster_natural_ML, element ele) {
    return  virginDMG(monster_natural_ML) * (1-(elemental_resistance(ele)/100));
}

float rounder(float number, int place) {
	float value = round(number*10.0**-place)*10.0**place;
	return value;
}

void main(float monster_natural_ML) {
    notify aenimus;
    print("You will take approximately " + rounder(damage(monster_natural_ML, hot),-1) + " from a hot monster's initial elemental hit.", "red");
    print("You will take approximately " + rounder(damage(monster_natural_ML, cold),-1) + " from a cold monster's initial elemental hit.", "blue");
    print("You will take approximately " + rounder(damage(monster_natural_ML, spooky),-1) + " from a spooky monster's initial elemental hit.", "gray");
    print("You will take approximately " + rounder(damage(monster_natural_ML, stench),-1) + " from a stench monster's initial elemental hit.", "green");
    print("You will take approximately " + rounder(damage(monster_natural_ML, sleaze),-1) + " from a sleaze monster's initial elemental hit.", "purple");	
	print("Remember that the monster's natural ML is your mainstat for scalers.", "green");
}

