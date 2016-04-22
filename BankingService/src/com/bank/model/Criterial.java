package com.bank.model;

import java.util.List;

public class Criterial {
	private String service;
	private String state;

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}


	
	@Override
	public String toString() {
		return "Criterial [service=" + service + ", state=" + state + "]";
	}

}
