package com.eros.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;

public final class RequestWrapper extends HttpServletRequestWrapper {

    public RequestWrapper(HttpServletRequest servletRequest) {
	super(servletRequest);
    }

    public String[] getParameterValues(String parameter) {
	String[] values = super.getParameterValues(parameter);
	
	if (values == null) {
	    return null;
	}
	int count = values.length;
	String[] encodedValues = new String[count];
	for (int i = 0; i < count; i++) {
	    encodedValues[i] = cleanXSS(values[i]);
	    encodedValues[i] = cleanSQLInjection(values[i]);
	}
	return encodedValues;
    }

    public String getParameter(String parameter) {
	String value = super.getParameter(parameter);
	if (value == null) {
	    return null;
	}
	cleanXSS(value);
	return cleanSQLInjection(value);
    }

    public String getHeader(String name) {
	String value = super.getHeader(name);
	if (value == null)
	    return null;
	cleanXSS(value);
	return cleanSQLInjection(value);
    }

    private String cleanXSS(String value) {
	value = value.replaceAll("eval\\((.*)\\)", "");
	value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
	value = value.replaceAll("script", "");
	value = StringEscapeUtils.escapeHtml(value);
	return value;
    }

    private String cleanSQLInjection(String value) {
	// Removes '', ;, comments (--, /**/)
	String regex = "('(''|[^'])*')|[;]|(--[^\\r\\n]*)|(/\\*[\\w\\W]*?(?=\\*/)\\*/)";

	value = value.replaceAll(regex, "");
	return value;
    }
}