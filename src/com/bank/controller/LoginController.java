package com.bank.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bank.dao.CloudantClientMgr;
import com.bank.model.SignupInfo;
import com.bank.model.UserInfo;
import com.cloudant.client.org.lightcouch.NoDocumentException;

@Controller
public class LoginController {

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String showLogin(Model model) {
		UserInfo loginForm = new UserInfo();
		PackModel(model, false, "", loginForm);
		return "login";
	}

	@RequestMapping(value = "/doLogin", method = RequestMethod.POST)
	public String login(@ModelAttribute("SpringWeb") UserInfo loginform,
			Model model, HttpServletRequest request) throws Exception {

		String email = loginform.getEmail();
		String password = loginform.getPassword();
		System.out.println("login infor: email=" + email + ", password=" + password);
		// A simple authentication manager
		if (email != null && password != null) {
			try {
				UserInfo userInfo = CloudantClientMgr.getUserDB().find(
						UserInfo.class, email);
				System.out.println("Login: fetched userInfo " + userInfo.toString());
				if (userInfo.getPassword().equals(password)) {
					request.getSession()
							.setAttribute("LOGGEDIN_USER", userInfo);
					return "redirect:criterial";
				} else {
					PackModel(model, true, "Email or Password was incorrect",
							loginform);
					return "login";
				}
			} catch (NoDocumentException e) {
				PackModel(model, true, "Email or Password was incorrect",
						loginform);
				return "login";
			}
		} else {
			PackModel(model, true, "Email or Password was incorrect", loginform);
			return "login";
		}
	}

	private void PackModel(Model model, boolean noti, String notiMsg,
			UserInfo loginform) {
		model.addAttribute("noti", noti);
		model.addAttribute("notiMsg", notiMsg);
		model.addAttribute("loginAttribute", loginform);
	}
}
