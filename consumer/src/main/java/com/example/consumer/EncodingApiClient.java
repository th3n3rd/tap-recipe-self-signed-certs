package com.example.consumer;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
class EncodingApiClient {

    private final RestTemplate httpClient;

    EncodingApiClient(
        RestTemplateBuilder httpClientBuilder,
        EncodingApiConfig encodingApiConfig
    ) {
        this.httpClient = httpClientBuilder
            .rootUri(encodingApiConfig.uri())
            .build();
    }

    String encode(String input) {
        return httpClient.postForObject("/", input, String.class);
    }
}
