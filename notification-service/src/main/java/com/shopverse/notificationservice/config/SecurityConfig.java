package com.shopverse.notificationservice.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/actuator/**", "/api/test/**").permitAll() // allow Prometheus/Grafana + test APIs
                        .anyRequest().authenticated()
                )
                .csrf(csrf -> csrf.disable()) // disable CSRF for non-browser clients
                .httpBasic(Customizer.withDefaults()); // basic auth fallback

        return http.build();
    }
}
