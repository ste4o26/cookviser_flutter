package com.ste4o26.cookviser_rest_api.configurations;

import com.ste4o26.cookviser_rest_api.utils.JWTUtil;
import com.ste4o26.cookviser_rest_api.utils.JWTUtilImpl;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.models.parameters.Parameter;
import org.springdoc.core.customizers.OperationCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.modelmapper.ModelMapper;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
public class ApplicationBeanConfiguration {
    private ModelMapper modelMapper;
    private JWTUtil jwtUtil;
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Bean
    public ModelMapper modelMapper() {
        if (this.modelMapper == null) {
            this.modelMapper = new ModelMapper();
        }

        return this.modelMapper;
    }

    @Bean
    public JWTUtil jwtUtil() {
        if (this.jwtUtil == null) {
            this.jwtUtil = new JWTUtilImpl();
        }

        return this.jwtUtil;
    }

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        if (this.bCryptPasswordEncoder == null) {
            this.bCryptPasswordEncoder = new BCryptPasswordEncoder();
        }

        return this.bCryptPasswordEncoder;
    }

//    @Bean
//    public OperationCustomizer customize() {
//        return (operation, handlerMethod) -> operation.addParametersItem(
//                new Parameter()
//                        .in("header")
//                        .required(true)
//                        .allowEmptyValue(true)
//                        .description("Authorization")
//                        .name("Authorization"));
//    }

    @Configuration
    @SecurityScheme(
            name = "Bearer Authentication",
            type = SecuritySchemeType.HTTP,
            bearerFormat = "JWT",
            scheme = "bearer"
    )
    public class OpenAPI30Configuration {}
}
