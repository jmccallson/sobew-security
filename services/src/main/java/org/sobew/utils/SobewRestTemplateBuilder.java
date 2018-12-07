package org.sobew.utils;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class SobewRestTemplateBuilder {
  private final RestTemplate restTemplate;

  SobewRestTemplateBuilder(RestTemplateBuilder restTemplateBuilder){
    this.restTemplate = restTemplateBuilder.rootUri("locate://sobew.org").build();
  }
}
