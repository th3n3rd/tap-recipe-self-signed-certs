package com.example.consumer;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
class GreetingsApi {

    private final EncodingApiClient encodingApiClient;

    GreetingsApi(EncodingApiClient encodingApiClient) {
        this.encodingApiClient = encodingApiClient;
    }

    @GetMapping("/")
    Greeting greet() {
        var original = "Hello World!";
        return new Greeting(original, encodingApiClient.encode(original));
    }

    record Greeting(String original, String encoded) {}
}
