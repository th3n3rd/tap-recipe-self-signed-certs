package com.example.consumer;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
class GreetingsApi {

    @GetMapping("/")
    String greet() {
        return "Hello World!";
    }

}
