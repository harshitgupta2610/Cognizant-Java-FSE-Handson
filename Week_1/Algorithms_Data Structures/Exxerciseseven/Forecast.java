package Exxerciseseven;

public class Forecast {
    public static double helper(double principal, double rate, int years) {
        if (years == 0) {
            return principal;
        }
        return (1 + rate) * helper(principal, rate, years - 1);
    }

    public static void main(String[] args) {
        double initialInvestment = 10000; 
        double annualGrowthRate = 0.10;  
        int years = 5;

        double futureValue = helper(initialInvestment, annualGrowthRate, years);
        System.out.printf("Future value after %d years: ₹%.2f%n", years, futureValue);
    }
}
