package com.bank.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	private final String[] displayBanks = { "Bank of America",
			"Wells Fargo", "JPMorgan Chase", "Citibank",
			"U.S. Bancorp" };

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String redirect() {
		return "redirect:index";
	}

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request) {
		UserInfo loginForm = new UserInfo();
		if (request.getSession().getAttribute("FORCE_LOGIN") == null) {
			PackLoginModel(model, false, "", loginForm);
		} else {
			PackLoginModel(model, true, "Please login to use our service.",
					loginForm);
		}

		return "index";
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

	@RequestMapping(value = "/result", method = RequestMethod.GET)
	public String viewResult(Model model) {
		System.out.println("in viewResult");
		Response res = new Response();

		model.addAttribute("res", res);
		init(model);
		model.addAttribute("criterialForm", new Criterial());
		return "result";
	}

	@RequestMapping(value = "/addCriterial", method = RequestMethod.POST)
	public String addCriterial(
			@ModelAttribute("SpringWeb") Criterial criterial, Model model) {
		System.out.println(criterial.toString());
		// model.addAttribute("criterial", criterial);
		Response res = new Response();

		// assign criterial to response
		res.setCriterial(criterial);

		if (criterial.getService().equals("NONE")
				|| criterial.getState().equals("NONE")) {
			model.addAttribute("res", res);
			init(model);
			model.addAttribute("criterialForm", criterial);
			return "result";
		}

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

	@RequestMapping(value = "/sendCriterial", method = RequestMethod.POST)
	public String sendCriterial(@RequestBody String reqData, Model model) {
		System.out.println("sendCriterial: " + reqData);
		JSONObject jsonObject = new JSONObject(reqData);
		String service = jsonObject.getString("service");
		String state = jsonObject.getString("state");
		String postal_code = jsonObject.getString("postal_code");
		postal_code = postal_code.substring(0, 2) + "xxx";

		Response res = new Response();

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

			Key.ComplexKey keys = Key.complex(bankInfo.getName()).add(service)
					.add(state).add(postal_code);
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

		// assign Sentiment info
		List<Sentiment> sentimentInfoList = res.getSentimentList();

		ViewRequestBuilder sentimentView = null;
		try {
			sentimentView = CloudantClientMgr.getTwitterView();
		} catch (Exception e) {
			e.printStackTrace();
			// say st to client
		}
		for (int i = 0; i < banks.length; i++) {
			Sentiment sentiment = new Sentiment();
			sentiment.setBankName(banks[i]);
			System.out.println("bank: " + banks[i]);
			Key.ComplexKey keys = Key.complex(sentiment.getBankName()).add("positive");
			
			ViewRequest<ComplexKey, Integer> request = sentimentView
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

					sentiment.setPositive(value);
				}

				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			keys = Key.complex(sentiment.getBankName()).add("negative");
			
			request = sentimentView
					.newRequest(Key.Type.COMPLEX, Integer.class).group(true)
					.keys(keys).build();
			// perform the request and get the response
			try {
				response = request.getResponse();
				// loop through the rows of the response
				for (Row<ComplexKey, Integer> row : response.getRows()) {
					ComplexKey key = row.getKey();
					Integer value = row.getValue();
					System.out.println("Key: " + key.toString());
					System.out.println("Value: " + value);

					sentiment.setNegative(value);
				}

				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			sentimentInfoList.add(sentiment);
		}

		Criterial criterial = new Criterial();
		criterial.setService(service);
		criterial.setState(state);
		criterial.setPostalCode(postal_code);
		res.setCriterial(criterial);
		model.addAttribute("res", res);
		model.addAttribute("bank", RecommendedBank(bankInfoList, sentimentInfoList));
		return "graphcontent";
	}

	private String RecommendedBank(List<BankInfo> bankInfoList,
			List<Sentiment> sentimentInfoList) {
		// TODO Auto-generated method stub
		int index = 0;
		double val = -10000;
		
		int totalComplaints = 0;
		for (int i = 0; i < bankInfoList.size();i++) {
			totalComplaints += bankInfoList.get(i).getComplaints();
		}
		
		for (int i = 0; i < bankInfoList.size(); i++) {
			double complaint = 3 * ((double) bankInfoList.get(i).getComplaints()) *100 / totalComplaints;
			double positivePercent = ((double) sentimentInfoList.get(i).getPositive()) *100 / (sentimentInfoList.get(i).getPositive() + sentimentInfoList.get(i).getNegative());
			double negativePercent = ((double) sentimentInfoList.get(i).getNegative()) *100 / (sentimentInfoList.get(i).getPositive() + sentimentInfoList.get(i).getNegative());
			double diffPercent = positivePercent-negativePercent;
			double diff = (diffPercent-complaint)/4;
			System.out.println("Bank name check: " + bankInfoList.get(i).getName() + "---" + sentimentInfoList.get(i).getBankName() + "---" + displayBanks[i] + ":" + diff);
			if (val < diff) {
				val = diff;
				index = i;
			}
		}
		String chosen = displayBanks[index];
		System.out.println("Bank chosen: " + chosen);
		return chosen;
	}

	private Database getDB() {
		return CloudantClientMgr.getDB();
	}

	private ViewRequestBuilder getViewBuilder() {
		return CloudantClientMgr.getServiceStateView();
	}

	private void PackLoginModel(Model model, boolean noti, String notiMsg,
			UserInfo loginform) {
		model.addAttribute("noti", noti);
		model.addAttribute("notiMsg", notiMsg);
		model.addAttribute("loginAttribute", loginform);
	}

}
