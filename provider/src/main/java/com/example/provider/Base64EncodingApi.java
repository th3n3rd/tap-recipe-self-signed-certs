package com.example.provider;

import java.nio.charset.StandardCharsets;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
class Base64EncodingApi {

    @PostMapping("/")
    String encode(@RequestBody String input) {
        return Base64.encodeBase64String(input.getBytes(StandardCharsets.UTF_8));
    }

}
