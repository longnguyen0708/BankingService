package com.bank.controller;

import java.util.HashMap;
import java.util.Map;

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
public class SignupController {
	private final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
			+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String showSignup(Model model) {
		SignupInfo signupForm = new SignupInfo();
		PackModel(model, false, "", signupForm);
		return "signup";
	}

	@RequestMapping(value = "/doSignup", method = RequestMethod.POST)
	public String signup(@ModelAttribute("SpringWeb") SignupInfo signupform,
			Model model, HttpServletRequest request) {

		String username = signupform.getUsername();
		String email = signupform.getEmail();
		String password = signupform.getPassword();
		String passwordAgain = signupform.getPasswordAgain();

		if (!email.matches(EMAIL_PATTERN)) {
			PackModel(model, true, "Invalid email address format", signupform);
			return "signup";
		} else {
			if (username != null && password != null) {
				if (password.length() >= 6) {
					if (password.equals(passwordAgain)) {
						try {
							CloudantClientMgr.getUserDB().find(UserInfo.class,
									email);
							PackModel(model, true, "This user already exists",
									signupform);
							return "signup";
						} catch (NoDocumentException e) {
							System.out
									.println("valid signup information, do store user info to userDB");
						}

						UserInfo newUser = new UserInfo();
						newUser.set_id(email);
						newUser.setUsername(username);
						newUser.setPassword(password);
						newUser.setEmail(email);
						// save user to db
						CloudantClientMgr.getUserDB().post(newUser);

						request.getSession().setAttribute("LOGGEDIN_USER",
								newUser);
						return "redirect:criterial";
					} else {
						PackModel(model, true, "Password does not match",
								signupform);
						return "signup";
					}
				} else {
					PackModel(model, true,
							"Password must contain at least 6 characters",
							signupform);
					return "signup";
				}

			} else {
				PackModel(model, true, "Empty User Name or Password",
						signupform);
				return "signup";
			}
		}

	}

	private void PackModel(Model model, boolean noti, String notiMsg,
			SignupInfo signupform) {
		model.addAttribute("noti", noti);
		model.addAttribute("notiMsg", notiMsg);
		model.addAttribute("signupAttribute", signupform);
	}
}
