package com.bank.model;

import java.util.ArrayList;
import java.util.List;

public class Response {
	private Criterial criterial;
	private List<BankInfo> bankList;
	private List<Sentiment> sentimentList;
	
	public Response() {
		super();
		bankList = new ArrayList<BankInfo>();
		sentimentList = new ArrayList<Sentiment>();
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
	public List<Sentiment> getSentimentList() {
		return sentimentList;
	}
	public void setSentimentList(List<Sentiment> sentimentList) {
		this.sentimentList = sentimentList;
	}
	
}
