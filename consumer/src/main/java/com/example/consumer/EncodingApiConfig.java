package com.example.consumer;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@ConfigurationProperties("encoding-api")
record EncodingApiConfig(String uri) {}
