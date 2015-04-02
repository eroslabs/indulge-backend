package com.eros.filter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
/**
 * 
 * @author 
 *
 */
@Component
public final class SecurityContextAccessorImpl implements ISecurityContextAccessor{

	@Autowired
	private AuthenticationTrustResolver authenticationTrustResolver;

	public boolean isAnonymous() {
		final Authentication authentication =SecurityContextHolder.getContext().getAuthentication();
		if(authentication == null)return true;
		return authenticationTrustResolver.isAnonymous(authentication);
	}
}
