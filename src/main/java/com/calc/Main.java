package com.calc;

import static spark.Spark.*;

public class Main {
    public static void main(String[] args) {
        port(4567);

        get("/", (request, response) -> {
            String html = "<html><body>";
            html += "<h1>Calculator App</h1>";
            html += "<form action=\"/calculate\" method=\"post\">";
            html += "<input type=\"text\" name=\"expression\" placeholder=\"Enter your expression\" />";
            html += "<input type=\"submit\" value=\"Calculate\" />";
            html += "</form>";
            html += "</body></html>";
            return html;
        });

        post("/calculate", (request, response) -> {
            String expression = request.queryParams("expression");
            double result = Calculator.calculate(expression);
            return "Result: " + result;
        });
    }
}
