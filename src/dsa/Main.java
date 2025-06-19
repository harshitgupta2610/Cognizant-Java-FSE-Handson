package dsa;
public class Main {
    public static void main(String[] args) {
        Product[] products = {
            new Product(101, "Laptop", "Electronics"),
            new Product(102, "Shoes", "Footwear"),
            new Product(103, "Mobile", "Electronics"),
            new Product(104, "T-shirt", "Apparel"),
            new Product(105, "Book", "Stationery")
        };

        String searchName = "Mobile";

        // Linear Search
        Product result1 = SearchEngine.linearSearch(products, searchName);
        System.out.println("Linear Search Result: " + (result1 != null ? result1 : "Product not found"));

        // Binary Search
        Product result2 = SearchEngine.binarySearch(products, searchName);
        System.out.println("Binary Search Result: " + (result2 != null ? result2 : "Product not found"));
    }
}
