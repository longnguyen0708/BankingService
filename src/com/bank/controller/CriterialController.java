package com.bank.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bank.dao.CloudantClientMgr;
import com.bank.model.*;
import com.cloudant.client.api.Database;
import com.cloudant.client.api.views.Key;
import com.cloudant.client.api.views.Key.ComplexKey;
import com.cloudant.client.api.views.ViewRequest;
import com.cloudant.client.api.views.ViewRequestBuilder;
import com.cloudant.client.api.views.ViewResponse;
import com.cloudant.client.api.views.ViewResponse.Row;

@Controller
public class CriterialController {

	private final String[] banks = { "Bank of America",
			"Wells Fargo & Company", "JPMorgan Chase & Co.", "Citibank",
			"U.S. Bancorp" };

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String redirect() {
		return "redirect:criterial";
	}

	@RequestMapping(value = "/criterial", method = RequestMethod.GET)
	public String criterial(Model model) {
		Criterial cri = new Criterial();
		init(model);
		model.addAttribute("criterialForm", cri);
		return "criterial";
	}

	private void init(Model model) {
		// TODO Auto-generated method stub
		List<String> serviceList = new ArrayList<String>();
		serviceList.add("Debt collection");
		serviceList.add("Credit reporting");
		serviceList.add("Credit card");
		serviceList.add("Bank account or service");
		serviceList.add("Consumer Loan");
		serviceList.add("Money transfers");
		serviceList.add("Mortgage");
		serviceList.add("Other financial service");
		serviceList.add("Payday loan");
		serviceList.add("Prepaid card");
		serviceList.add("Student loan");

		model.addAttribute("serviceList", serviceList);

		List<String> stateList = new ArrayList<String>();

		stateList.add("AZ");
		stateList.add("CA");
		stateList.add("CT");

		stateList.add("FL");
		stateList.add("GA");

		stateList.add("IL");

		stateList.add("MA");
		stateList.add("MD");

		stateList.add("MI");

		stateList.add("MO");

		stateList.add("NC");

		stateList.add("NJ");
		stateList.add("NV");
		stateList.add("NY");
		stateList.add("OR");
		stateList.add("PA");
		stateList.add("SC");
		stateList.add("TN");
		stateList.add("TX");
		stateList.add("VA");
		stateList.add("WA");

		model.addAttribute("stateList", stateList);
	}

	@RequestMapping(value = "/addCriterial", method = RequestMethod.POST)
	public String addCriterial(
			@ModelAttribute("SpringWeb") Criterial criterial, Model model) {
		System.out.println(criterial.toString());
		// model.addAttribute("criterial", criterial);
		Response res = new Response();

		// assign criterial to response
		res.setCriterial(criterial);

		// assign Bank info
		List<BankInfo> bankInfoList = res.getBankList();

		ViewRequestBuilder view = null;
		try {
			view = getViewBuilder();
		} catch (Exception e) {
			e.printStackTrace();
			// say st to client
		}
		for (int i = 0; i < banks.length; i++) {
			BankInfo bankInfo = new BankInfo();
			bankInfo.setName(banks[i]);

			Key.ComplexKey keys = Key.complex(bankInfo.getName())
					.add(criterial.getService()).add(criterial.getState());
			ViewRequest<ComplexKey, Integer> request = view
					.newRequest(Key.Type.COMPLEX, Integer.class).group(true)
					.keys(keys).build();
			// perform the request and get the response
			ViewResponse<ComplexKey, Integer> response;
			try {
				response = request.getResponse();
				// loop through the rows of the response
				for (Row<ComplexKey, Integer> row : response.getRows()) {
					ComplexKey key = row.getKey();
					Integer value = row.getValue();
					System.out.println("Key: " + key.toString());
					System.out.println("Value: " + value);

					bankInfo.setComplaints(value);
				}

				bankInfoList.add(bankInfo);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		model.addAttribute("res", res);
		init(model);
		model.addAttribute("criterialForm", criterial);
		return "result";
	}

	private Database getDB() {
		return CloudantClientMgr.getDB();
	}

	private ViewRequestBuilder getViewBuilder() {
		return CloudantClientMgr.getServiceStateView();
	}

}
