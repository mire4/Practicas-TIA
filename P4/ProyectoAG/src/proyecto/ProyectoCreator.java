package proyecto;

import java.util.Random;

import org.opt4j.core.genotype.IntegerGenotype;
import org.opt4j.core.problem.Creator;

public class ProyectoCreator implements Creator<IntegerGenotype>
{
	public IntegerGenotype create() {

		IntegerGenotype genotype = new IntegerGenotype(-1, Data.NUM_ORDENADORES - 1);
		genotype.init(new Random(), Data.NUM_PROCESOS);

		return genotype;
	}
}
