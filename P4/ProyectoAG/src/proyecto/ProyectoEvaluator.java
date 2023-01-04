package proyecto;

import java.util.ArrayList;

import org.opt4j.core.Objective.Sign;
import org.opt4j.core.Objectives;
import org.opt4j.core.problem.Evaluator;

public class ProyectoEvaluator implements Evaluator<ArrayList<Integer>>
{
	public Objectives evaluate(ArrayList<Integer> phenotype) {
		double beneficio = 0;
		double memoria = 0;
		int[] capacidadTotal = new int[Data.NUM_ORDENADORES];
		double[] memoriaTotal = new double[Data.NUM_ORDENADORES];
		
		for(int i = 0; i < phenotype.size(); i++) {
			double ramProceso = Data.RAM[i];
			double beneficioProceso = Data.beneficio[i];
			int ordenador = phenotype.get(i);
			
			if(ordenador != -1) {
				if (capacidadTotal[ordenador] + 1 <= Data.capacidad[ordenador] 
						&& memoriaTotal[ordenador] + ramProceso <= Data.memoria[ordenador]) {
					capacidadTotal[ordenador] += 1;
					memoriaTotal[ordenador] += ramProceso;
					beneficio += beneficioProceso;
				} else {
					beneficio = Double.NEGATIVE_INFINITY;
				}
			}
		}
		
		for(int i = 0; i < memoriaTotal.length; i++) {
			memoria += memoriaTotal[i];
		}
		
		Objectives objectives = new Objectives();
		objectives.add("Beneficio total", Sign.MAX, beneficio);
		objectives.add("Memoria total", Sign.MIN, memoria);
		return objectives;
	}
}
