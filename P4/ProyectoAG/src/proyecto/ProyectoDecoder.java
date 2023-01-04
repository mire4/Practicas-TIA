package proyecto;

import java.util.ArrayList;

import org.opt4j.core.genotype.IntegerGenotype;
import org.opt4j.core.problem.Decoder;

public class ProyectoDecoder implements Decoder<IntegerGenotype, ArrayList<Integer>>
{
	public ArrayList<Integer> decode(IntegerGenotype genotype) { 
		ArrayList<Integer> phenotype = new ArrayList<Integer>();
		int[] capacidadTotal = new int[Data.NUM_ORDENADORES];
		double[] memoriaTotal = new double[Data.NUM_ORDENADORES];
		
		for (int i = 0; i < genotype.size(); i++) {
			double ramProceso = Data.RAM[i];
			int ordenador = genotype.get(i);
			
			if(ordenador != -1) {
				if (capacidadTotal[ordenador] + 1 <= Data.capacidad[ordenador] 
						&& memoriaTotal[ordenador] + ramProceso <= Data.memoria[ordenador]) {
					capacidadTotal[ordenador] += 1;
					memoriaTotal[ordenador] += ramProceso;
					phenotype.add(genotype.get(i));
				} else {
					phenotype.add(-1);
				}
			}
		}
		return phenotype;
	}
}
