package com.bank.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bank.model.UserInfo;

@Component
public class AuthenticationInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		System.out
				.println("AuthenticationInterceptor: REQUEST Intercepted for URI: "
						+ request.getRequestURI());
		// Avoid a redirect loop for some urls
		if (!request.getRequestURI().equals("/")
				&& !request.getRequestURI().equals("/doLogin")
				&& !request.getRequestURI().equals("/login")
				&& !request.getRequestURI().equals("/signup")
				&& !request.getRequestURI().equals("/doSignup")
				&& !request.getRequestURI().equals("/index")){
			UserInfo userData = (UserInfo) request.getSession().getAttribute(
					"LOGGEDIN_USER");
			if (userData == null) {
				request.getSession().setAttribute("FORCE_LOGIN", "YES");
				response.sendRedirect("/index");
				return false;
			}
		}
		return true;
	}
}
