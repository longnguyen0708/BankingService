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

import com.bank.model.LoginForm;

@Controller
public class LoginController {

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String showLogin(Model model) {
		LoginForm loginForm = new LoginForm();
		model.addAttribute("loginAttribute", loginForm);
		boolean error = false;
		String msg = "";
		model.addAttribute("error", error);
		model.addAttribute("errorMsg", msg);
		return "login";
	}

	@RequestMapping(value = "/doLogin", method = RequestMethod.POST)
	public String login(@ModelAttribute("SpringWeb") LoginForm loginform,
			Model model, HttpServletRequest request) throws Exception {

		String username = loginform.getUsername();
		String password = loginform.getPassword();

		// A simple authentication manager
		if (username != null && password != null) {

			if (username.equals("long")
					&& password.equals("79")) {
				// Set a session attribute to check authentication then redirect
				// to the welcome uri;
				request.getSession().setAttribute("LOGGEDIN_USER", loginform);
				return "redirect:criterial";
			} else {
				boolean error = true;
				String msg = "Wrong User name or Password";
				model.addAttribute("error", error);
				model.addAttribute("errorMsg", msg);
				model.addAttribute("loginAttribute", loginform);
				return "login";
			}
		} else {
			boolean error = true;
			String msg = "Empty User name or Password";
			model.addAttribute("error", error);
			model.addAttribute("errorMsg", msg);
			model.addAttribute("loginAttribute", loginform);
			return "login";
		}
	}
}
