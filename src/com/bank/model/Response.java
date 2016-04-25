package com.bank.model;

import java.util.ArrayList;
import java.util.List;

public class Response {
	private Criterial criterial;
	private List<BankInfo> bankList;
	
	public Response() {
		super();
		bankList = new ArrayList<BankInfo>();
	}
	public Criterial getCriterial() {
		return criterial;
	}
	public void setCriterial(Criterial criterial) {
		this.criterial = criterial;
	}
	public List<BankInfo> getBankList() {
		return bankList;
	}
	public void setBankList(List<BankInfo> bankList) {
		this.bankList = bankList;
	}
	
}
