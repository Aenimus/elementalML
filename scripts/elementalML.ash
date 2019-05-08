script elementalML

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

float reduction(float your_relevant_elem_res) {
    if(your_relevant_elem_res < 4) {
		float res = your_relevant_elem_res/10;
		if(my_class() == $class[sauceror] || my_class() == $class[pastamancer]) {
			float res = res + 0.05;
		}
        return 1 - res;
    } else {
		 float res = your_relevant_elem_res - 4;
		 float fraction = 5.0/6;
		 float first = pow(fraction, res);
		 float second = 0.1 + (0.5 * first);
		 if(my_class() == $class[sauceror] || my_class() == $class[pastamancer]) {
			float second = second - 0.05;
		}
        return second;
    }
}

float totalML(float monster_natural_ML, float monster_bonus_ML) {
    return monster_natural_ML + monster_bonus_ML;
}

float calcML(float monster_bonus_ML) {
    return monster_bonus_ML - 25;
}

float virginDMG(float monster_natural_ML, float monster_bonus_ML) {
    return (totalML(monster_natural_ML, monster_bonus_ML) * calcML(monster_bonus_ML))/500;
}

float damage(float monster_natural_ML, float monster_bonus_ML, float your_relevant_elem_res) {
    return  virginDMG(monster_natural_ML, monster_bonus_ML) * reduction(your_relevant_elem_res);
}

float rounder(float number, int place) {
	float value = round(number*10.0**-place)*10.0**place;
	return value;
}

void main(float monster_natural_ML, float monster_bonus_ML, float your_relevant_elem_res) {
    notify aenimus;
    print("You will take approximately " + rounder(damage(monster_natural_ML, monster_bonus_ML, your_relevant_elem_res),-1) + " from the monster's initial elemental hit.", "blue");
	print("Remember that the monster's natural ML is your mainstat for scalers.", "purple");
}

