package com.eros.listener;

import javax.servlet.ServletContextEvent;

import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;


@Component
public class IndulgeContextListner extends ContextLoaderListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
	super.contextInitialized(event);

	WebApplicationContext webApplicationContext = this.getCurrentWebApplicationContext();
//	ELibraryService ebookService = (ELibraryService) webApplicationContext.getBean("indulgeService");

	
//				event.getServletContext().setAttribute("menuSubjects", productFacet.getFacetValues());
		
	}

    }

