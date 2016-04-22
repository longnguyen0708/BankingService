package com.bank.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bank.model.Criterial;

@Controller
public class CriterialController {
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
		model.addAttribute("serviceList", serviceList);

		List<String> stateList = new ArrayList<String>();
		stateList.add("CA");
		stateList.add("TX");
		model.addAttribute("stateList", stateList);
	}

	@RequestMapping(value = "/addCriterial", method = RequestMethod.POST)
	public String addCriterial(@ModelAttribute("SpringWeb") Criterial criterial,
			ModelMap model) {
		System.out.println(criterial.toString());
		model.addAttribute("criterial", criterial);
		return "result";
	}

}
