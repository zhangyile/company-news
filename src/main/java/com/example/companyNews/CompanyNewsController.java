package hello;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class CompanyNewsController {

    @RequestMapping("/")
    public String index() {
        return "Greetings from Spring Boot! Hello World, I am master";
    }

}
