package com.capgemini.asynccommand;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;

public class CommandWorker implements Command {
	
	List<Function<Object, Object>> functionList = new ArrayList<Function<Object,Object>>();
	
	@Override
	public void execute() {
		
	}
	
	public int currentIndex() {
		
		return 0;
	}
	
	public void addFunction(Function<Object,Object> func) {
		functionList.add(func);
	}

}
