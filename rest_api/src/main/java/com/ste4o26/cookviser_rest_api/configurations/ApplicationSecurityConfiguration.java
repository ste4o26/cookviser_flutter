package com.ste4o26.cookviser_rest_api.configurations;

import com.ste4o26.cookviser_rest_api.services.UserDetailsServiceImpl;
import com.ste4o26.cookviser_rest_api.services.interfaces.UserService;
import com.ste4o26.cookviser_rest_api.web.handlers.JWTAccessDeniedHandler;
import com.ste4o26.cookviser_rest_api.web.filters.JWTAuthorizationFilter;
import com.ste4o26.cookviser_rest_api.web.handlers.JWTAuthenticationEntryPointHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.WebSecurityConfigurer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class ApplicationSecurityConfiguration extends WebSecurityConfigurerAdapter {
    private static final String[] PUBLIC_URLS = {"/auth/**",
            "/recipe/all", "/recipe/all-categories", "/recipe/details", "/recipe/next-by-cuisine",
            "/recipe/best-four", "/recipe/next-recipes", "/cuisine/all", "/cuisine/first-four-most-populated",
            "/user/best-three", "/swagger-ui.html", "/swagger-ui/**", "/v3/api-docs/**"};

    public static final String[] SWAGGER_URLS = {"/swagger-ui.html", "/swagger-ui/**", "/v3/api-docs/**"};

    private final UserDetailsServiceImpl userDetailsService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final JWTAuthorizationFilter jwtAuthorizationFilter;
    private final JWTAccessDeniedHandler jwtAccessDeniedHandler;
    private final JWTAuthenticationEntryPointHandler jwtAuthenticationEntryPointHandler;

    @Autowired
    public ApplicationSecurityConfiguration(UserDetailsServiceImpl userDetailsService,
                                            BCryptPasswordEncoder bCryptPasswordEncoder,
                                            JWTAuthorizationFilter jwtAuthorizationFilter,
                                            JWTAccessDeniedHandler jwtAccessDeniedHandler,
                                            JWTAuthenticationEntryPointHandler jwtAuthenticationEntryPointHandler) {
        this.userDetailsService = userDetailsService;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.jwtAuthorizationFilter = jwtAuthorizationFilter;
        this.jwtAccessDeniedHandler = jwtAccessDeniedHandler;
        this.jwtAuthenticationEntryPointHandler = jwtAuthenticationEntryPointHandler;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(this.userDetailsService)
                .passwordEncoder(this.bCryptPasswordEncoder);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable().cors()
                .and().sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and().authorizeRequests().antMatchers(HttpMethod.GET, SWAGGER_URLS).permitAll()
                .and().authorizeRequests().antMatchers(PUBLIC_URLS).permitAll().anyRequest().authenticated()
                .and().exceptionHandling()
                .authenticationEntryPoint(this.jwtAuthenticationEntryPointHandler)
                .accessDeniedHandler(this.jwtAccessDeniedHandler)
                .and().addFilterBefore(this.jwtAuthorizationFilter, UsernamePasswordAuthenticationFilter.class);
    }

    @Override
    @Bean
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}
