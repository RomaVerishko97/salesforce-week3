@isTest
public class AddProductTest {
    public static void addProduct(Integer quantity){
        List<Product_Table__c> product = new List<Product_Table__c>();
        for(Integer i=0; i < quantity; i++) {
            product.add(new Product_Table__c(Name = 'Product №' + i,
                                            Image_URL__c = 'https://mobidevices.ru/images/2017/03/Galaxy-S8.jpg',
                                            Product_Description__c = 'Основные функции Вибровызов есть MMS есть Диктофон есть Передача данных',
                                            Unit_Price__c = 500 + i,
                                            Units_Available__c = i));
        }
        insert product;
    }

}